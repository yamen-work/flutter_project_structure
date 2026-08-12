import 'package:exercise_projects/core/bindings/app_bindings.dart';
import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/core/services/remote_api_service.dart';
import 'package:exercise_projects/features/auth/bloc/auth_cubit.dart';
import 'package:exercise_projects/features/auth/presentation/screens/login_screen.dart';
import 'package:exercise_projects/features/cart_screen/logic/cart_provider.dart';
import 'package:exercise_projects/features/category_screen/presentation/categories_screen.dart';
import 'package:exercise_projects/features/category_screen_getx/presentation/topics_screen.dart';
import 'package:exercise_projects/features/home/bloc/home_screen_cubit.dart';
import 'package:exercise_projects/features/main_layout/main_layout.dart';
import 'package:exercise_projects/features/review_screen/bloc/review_bloc.dart';
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
import 'features/auth/data/auth_data_source.dart';
import 'features/category_screen/bloc/categories_bloc.dart';
import 'features/review_screen/presentation/reviwes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
                  BlocProvider(create: (context) => AuthCubit(remoteDatasource: context.read<AuthRemoteDataSource>()),)

                ],
                child: GetMaterialApp(
                  theme: ThemeData(
                    colorScheme: .fromSeed(seedColor: Colors.blue),
                    fontFamily: "Tajawal",
                  ),
                  debugShowCheckedModeBanner: false,
                  initialBinding: AppBindings(),
                  home: LoginScreen(),
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
