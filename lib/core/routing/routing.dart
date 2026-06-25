import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/main_layout/main_layout.dart';


abstract class Routes
{
  static const String mainLayout = "/mainLayout";

  static const String landingPages = "/landing_page";

  static const String homepage = "home_page";

  /// auth related
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String confirmAccount = "/auth/confirm_account";
  static const String forgetPassword = "/auth/forget_password";
  static const String resetPassword = "/auth/reset_password";


  /// drawer items
  static const String aboutUs = "/aboutUs";
  static const String searchScreen = "/searchScreen";
  static const String privacyPolicy = "/privacyPolicy";
  static const String socialMedia = "/socialMedia";


  static const String profile = "/user_profile";


  static const String notifications = "/notifications";
  static const String moreScreen = "/moreScreen";
  static const String favorites = "/favorites";
  static const String appUpdates = "/appUpdates";
}

bool isLoggedIn= false;

Route<dynamic>? onGenerateRoute(RouteSettings settings) {


  final args = settings.arguments as Map<String, dynamic>?;

  switch (settings.name) {


    case Routes.mainLayout:
      return MaterialPageRoute(
        builder: (_) => const MainLayout(),
        settings: const RouteSettings(name: Routes.mainLayout),
      );


    case Routes.login:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: const RouteSettings(name: Routes.login),
      );

    case Routes.register:
      return MaterialPageRoute(
        builder: (_) => const RegisterScreen(),
        settings: const RouteSettings(name: Routes.register),
      );


    // case Routes.profile:
    //   if (!isLoggedIn) {
    //     return MaterialPageRoute(
    //       builder: (_) => const Scaffold(
    //         body: Center(
    //           child: Text("Please login first"),
    //         ),
    //       ),
    //     );
    //   }
    //   else
    //     {
    //       final name = args?['name'] ?? "Tamkeen";
    //       return MaterialPageRoute(
    //         builder: (_) => ProfileScreen(username: name),
    //         settings: const RouteSettings(name: Routes.profile),
    //       );
    //     }

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text("No route defined"))),
        settings: const RouteSettings(name: 'undefined'),
      );
  }
}
