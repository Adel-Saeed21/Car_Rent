import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/feature/auth/home/home.dart';
import 'package:carrent/feature/auth/log_in/UI/log_in_screen.dart';
import 'package:carrent/feature/auth/log_in/logic/log_in_cubit.dart';
import 'package:carrent/feature/auth/sign_up/UI/sign_up_screen.dart';
import 'package:carrent/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carrent/feature/navigation_screen.dart/navigation_screen.dart';
import 'package:carrent/feature/onBoarding/UI/onboarding_screen.dart';
import 'package:carrent/feature/onBoarding/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.startScreen:
        return MaterialPageRoute(builder: (_) => const StartScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getit<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const Home());

      case Routes.navigationScreen:
        return MaterialPageRoute(builder: (_) =>const NavigationScreen());

      case Routes.logInScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LogInCubit>(
            create: (context) => getit<LogInCubit>(),
            child: const LogInScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
