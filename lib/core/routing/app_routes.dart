import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/feature/onBoarding/UI/onboarding_screen.dart';
import 'package:carrent/feature/onBoarding/start_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case Routes.startScreen:
        return MaterialPageRoute(builder: (_) => StartScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
