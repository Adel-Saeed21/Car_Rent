import 'dart:async';
import 'package:carrent/car_rent_app.dart';
import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/routing/app_routes.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/feature/booking/data/models/booking_model.dart';
import 'package:carrent/feature/favorite/data/models/favorite_model.dart';
import 'package:carrent/feature/feedback/data/models/feedback_model.dart';
import 'package:carrent/feature/booking/domain/repositories/i_booking_repository.dart';
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
  Hive.registerAdapter(FavoriteModelAdapter());
  Hive.registerAdapter(BookingModelAdapter());
  Hive.registerAdapter(BookingStatusModelAdapter());
  Hive.registerAdapter(FeedbackModelAdapter());
  Hive.registerAdapter(FeedbackItemModelAdapter());

   
  await Hive.openBox<UserData>('userDataBox');

  await setUpDI();

  await getit.allReady();

   
  Timer.periodic(const Duration(hours: 1), (timer) {
    try {
      getit<IBookingRepository>().updateExpiredBookings();
    } catch (e) {
      debugPrint('Error updating expired bookings: $e');
    }
  });

   
  try {
    getit<IBookingRepository>().updateExpiredBookings();
  } catch (e) {
    debugPrint('Error updating expired bookings on startup: $e');
  }

  runApp(
    CarRentApp(
      appRouter: AppRoute(),
      initialRoute: Routes.startScreen,
    ),
  );
}
