import 'package:carrent/car_rent_app.dart';
import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/routing/app_routes.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpDI();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox<UserData>('userDataBox');
  runApp(CarRentApp(appRouter: AppRoute()));
}
