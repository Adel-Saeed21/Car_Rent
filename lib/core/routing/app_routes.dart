import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/feature/auth/log_in/UI/log_in_screen.dart';
import 'package:carrent/feature/auth/sign_up/UI/sign_up_screen.dart';
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
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.logInScreen:
        return MaterialPageRoute(builder: (_) => LogInScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
