import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/feature/onBoarding/UI/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
    default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }



}