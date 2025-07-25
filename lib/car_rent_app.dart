import 'package:carrent/core/routing/app_routes.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarRentApp extends StatelessWidget {
  const CarRentApp({super.key, required this.appRouter});
      final AppRoute appRouter;

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Car Rent App',
          initialRoute: Routes.onBoardingScreen ,
          debugShowMaterialGrid: false ,
          onGenerateRoute: appRouter.generateRoute,
        )
    );
      }
}

 

