import 'package:exercise_projects/core/bindings/app_bindings.dart';
import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/core/services/firebase/firebase_service.dart';
import 'package:exercise_projects/core/services/remote_api_service.dart';
import 'package:exercise_projects/features/auth/bloc/auth_cubit.dart';
import 'package:exercise_projects/features/auth/presentation/screens/login_screen.dart';
import 'package:exercise_projects/features/cart_screen/logic/cart_provider.dart';
import 'package:exercise_projects/features/category_screen/presentation/categories_screen.dart';
import 'package:exercise_projects/features/category_screen_getx/presentation/topics_screen.dart';
import 'package:exercise_projects/features/home/bloc/home_screen_cubit.dart';
import 'package:exercise_projects/features/main_layout/main_layout.dart';
import 'package:exercise_projects/features/review_screen/bloc/review_bloc.dart';
import 'package:exercise_projects/features/users/presentation/users_screen.dart';
import 'package:exercise_projects/features/users/presentation/users_screen_getx.dart';
import 'package:exercise_projects/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart' hide FirebaseService;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Localization/l10n/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/secure_storage/token_storage_implementation.dart';
import 'core/secure_storage/token_storage_interface.dart';
import 'core/services/firebase/firebase_notifications_services.dart';
import 'features/auth/data/auth_data_source.dart';
import 'features/category_screen/bloc/categories_bloc.dart';
import 'features/users/bloc/users_cubit.dart';
import 'features/users/data/data_sources/local_data_source.dart';
import 'features/users/data/data_sources/remote_data_source.dart';
import 'features/users/data/reposititories/users_repo_implementation.dart';
import 'features/users/domain/repositories_interfaces/users_repo_interface.dart';
import 'features/users/domain/use_cases/get_users_use_case.dart';
import 'core/services/firebase/firebase_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
    'Background notification: ${message.notification?.title}',
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );
  await NotificationService.instance.initialize();
  await NotificationService.instance.handleInitialNotification();
  NotificationService.instance.getDeviceToken();

  AppConfig appConfig = AppConfig();
  await appConfig.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appConfig),

        Provider<TokenStorage>(
          create: (_) => SecureTokenStorage(
            const FlutterSecureStorage(),
          ),
        ),

        Provider<RemoteApiService>(
          create: (context) => RemoteApiService(
            context.read<TokenStorage>(),
          ),
        ),

        Provider<AuthRemoteDataSource>(
          create: (context) => AuthRemoteDataSource(
            api: context.read<RemoteApiService>(),
            tokenStorage: context.read<TokenStorage>(),
          ),
        ),

        Provider<UserRemoteDataSource>(
          create: (context) {
            return UserRemoteDataSource(
              context.read<RemoteApiService>(),
            );
          },
        ),

        Provider<UserLocalDataSource>(
          create: (context) {
            return UserLocalDataSource();
          },
        ),

        // ================= REPOSITORY =================

        Provider<UserRepository>(
          create: (context) {
            return UserRepositoryImpl(
              context.read<UserRemoteDataSource>(),
              context.read<UserLocalDataSource>(),
            );
          },
        ),

        // ================= USE CASE =================

        Provider<GetUsersUseCase>(
          create: (context) {
            return GetUsersUseCase(
              context.read<UserRepository>(),
            );
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 888),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Cart())],
          child: Consumer<AppConfig>(
            builder: (context,value,child) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => CategoriesCubit(service: context.read<RemoteApiService>()),),
                  BlocProvider(create: (context) => ReviewsCubit(service: context.read<RemoteApiService>()),),
                  BlocProvider<AuthCubit>(
                    create: (context) => AuthCubit(
                      firebaseService: FirebaseService.instance,
                    ),
                  ),
                  BlocProvider<UsersCubit>(
                    create: (context) {
                      return UsersCubit(
                        getUsersUseCase:
                        context.read<GetUsersUseCase>(),
                      );
                    },
                  ),
              ],
                child: GetMaterialApp(
                  navigatorKey: navigatorKey,
                  theme: ThemeData(
                    colorScheme: .fromSeed(seedColor: Colors.blue),
                    fontFamily: "Tajawal",
                  ),
                  debugShowCheckedModeBanner: false,
                  initialBinding: AppBindings(),
                  home:FirebaseService.instance.currentUser!=null?MainLayout(): LoginScreen(),
                  locale: Locale(value.selectedLanguage),
                  onGenerateRoute: onGenerateRoute,
                  supportedLocales: [Locale("en"), Locale("ar")],
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                ),
              );
            }
          ),
        );
      },
    );
  }
}
