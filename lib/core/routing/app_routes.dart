import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/feature/car/data/models/car_model.dart' as old_model;
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/Profile/profile_screen.dart';
import 'package:carrent/feature/auth/forget_password/logic/reset_password_cubit.dart';
import 'package:carrent/feature/auth/forget_password/ui/reset_password.dart';
import 'package:carrent/feature/auth/log_in/UI/log_in_screen.dart';
import 'package:carrent/feature/auth/log_in/logic/log_in_cubit.dart';
import 'package:carrent/feature/auth/sign_up/UI/sign_up_screen.dart';
import 'package:carrent/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carrent/feature/home/UI/home.dart';
import 'package:carrent/feature/navigation_screen.dart/navigation_screen.dart';
import 'package:carrent/feature/onBoarding/UI/onboarding_screen.dart';
import 'package:carrent/feature/onBoarding/start_screen.dart';
import 'package:carrent/feature/car_details/presentation/screens/car_details_screen.dart';
import 'package:carrent/feature/favorite/presentation/screens/favorite_screen.dart';
import 'package:carrent/feature/feedback/presentation/screens/feedback_screen.dart';
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
        return MaterialPageRoute(builder: (_) => const NavigationScreen());
      
      case Routes.favorite:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
        
      case Routes.feedback:
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());

      case Routes.carDetails:
        final args = settings.arguments;
        late CarEntity carEntity;

        if (args is CarEntity) {
          carEntity = args;
        } else if (args is old_model.CarModel) {
           
          carEntity = CarEntity(
            id: args.id.toString(),  
            name: args.name,
            brand: args.brand,
            imageAsset: args.imageAsset,
            pricePerDay: args.pricePerDay,
            maxSpeed: args.maxSpeed,
            seats: args.seats,
            features: args.features,
            carDataSpecification: args.carDataSpecification?.map((spec) => SpecificationData(
              iconColor:'red',
              iconName: 'default',  
              title: spec.title,
              value: spec.value,
            )).toList() ?? [],
          );
        } else {
           return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text("Invalid Car Arguments"))));
        }

        return MaterialPageRoute(
          builder: (_) => CarDetailsScreen(
            car: carEntity,
          ),
        );

      case Routes.logInScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LogInCubit>(
            create: (context) => getit<LogInCubit>(),
            child: const LogInScreen(),
          ),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getit<ResetPasswordCubit>(),
            child: const ResetPassword(),
          ),
        );

      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
