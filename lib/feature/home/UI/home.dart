import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/home/UI/widgets/home_custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: const Column(children: [HomeCustomAppBar()]),
        ),
      ),
    );
  }
}
