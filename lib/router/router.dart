import 'package:flutter/material.dart';
import 'package:softec/router/routes.dart';
import 'package:softec/screens/home/home.dart';
import 'package:softec/screens/login/login.dart';
import 'package:softec/screens/maps/maps.dart';
import 'package:softec/screens/sign_up/sign_up.dart';
import 'package:softec/screens/splash/splash.dart';

final Map<String, Widget Function(dynamic)> appRoutes = {
  AppRoutes.splash: (_) => const SplashScreen(),
  AppRoutes.home: (_) => const HomeScreen(),
  AppRoutes.login: (_) => const LoginScreen(),
  AppRoutes.signup: (_) => const SignUpScreen(),
  AppRoutes.map: (_) => const MapsScreen(),
};

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return FadeRoute(settings: settings, child: const SplashScreen());
    case AppRoutes.login:
      return FadeRoute(settings: settings, child: const LoginScreen());
    case AppRoutes.signup:
      return FadeRoute(settings: settings, child: const SignUpScreen());
    case AppRoutes.home:
      return FadeRoute(settings: settings, child: const HomeScreen());

    case AppRoutes.map:
      return FadeRoute(settings: settings, child: const MapsScreen());

    default:
      return null;
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;

  @override
  final RouteSettings settings;

  FadeRoute({required this.child, required this.settings})
    : super(
        settings: settings,
        pageBuilder: (context, ani1, ani2) => child,
        transitionsBuilder: (context, ani1, ani2, child) {
          return FadeTransition(opacity: ani1, child: child);
        },
      );
}
