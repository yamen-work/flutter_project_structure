import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/features/cart_screen/logic/cart_provider.dart';
import 'package:exercise_projects/features/home/bloc/home_screen_cubit.dart';
import 'package:exercise_projects/features/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'Localization/l10n/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig appConfig = AppConfig();
  await appConfig.init();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: appConfig)],
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
              return MaterialApp(
                theme: ThemeData(
                  colorScheme: .fromSeed(seedColor: Colors.blue),
                  fontFamily: "Tajawal",
                ),
                debugShowCheckedModeBanner: false,
                onGenerateRoute: onGenerateRoute,
                home: MainLayout(),
                locale: Locale(value.selectedLanguage),
                supportedLocales: [Locale("en"), Locale("ar")],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              );
            }
          ),
        );
      },
    );
  }
}
