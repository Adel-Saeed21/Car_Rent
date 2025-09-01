import 'dart:async';
import 'package:carrent/car_rent_app.dart';
import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/functions/is_user_login.dart';
import 'package:carrent/core/routing/app_routes.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/feature/Booking/data/booking_model.dart';
import 'package:carrent/feature/Booking/data/repo/booking_rep.dart';
import 'package:carrent/feature/FeedBack/data/feedback_model.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:carrent/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();

  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(FeedbackModelAdapter());
  Hive.registerAdapter(FeedbackItemAdapter());
  Hive.registerAdapter(BookingModelAdapter());
  Hive.registerAdapter(BookingStatusAdapter());

  await Hive.openBox<UserData>('userDataBox');

  await setUpDI();

  await getit.allReady();

  Timer.periodic(const Duration(hours: 1), (timer) {
    var bookingRepository = BookingRep();
    bookingRepository.updateExpiredBookings();
  });

  final loggedIn = isUserLoggedIn();

  runApp(
    CarRentApp(
      appRouter: AppRoute(),
      // initialRoute: loggedIn ? Routes.homeScreen : Routes.onBoardingScreen,
      initialRoute: Routes.navigationScreen,
    ),
  );
}
