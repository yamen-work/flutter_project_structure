import 'dart:ui';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/features/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Localization/l10n/app_localization.dart';



Locale currentLocale = Locale("en");

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
        fontFamily: "Tajawal",
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      home: MainLayout(),
      
      locale: currentLocale,


      supportedLocales: [Locale("en"), Locale("ar")],

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
