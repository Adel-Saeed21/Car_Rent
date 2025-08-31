import 'package:carrent/core/helpers/extensions.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/core/utils/app_assets.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/widgets/app_button.dart';
import 'package:carrent/feature/onBoarding/UI/widget/car_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              Assets.assetsImagesOnboardingBackground,
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpace(400.h),
                    const CarvOnLogo(),
                    verticalSpace(30.h),

                    AppButton(
                      buttonHeight: 40.h,
                      buttonWidth: 280.w,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                      onPressed: () {
                        context.pushNamed(Routes.signUpScreen);
                      },
                      backgroundColor: AppColors.lightBlue,
                      radius: 25.r,
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    AppButton(
                      buttonHeight: 40.h,
                      buttonWidth: 280.w,
                      textStyle: TextStyle(color: Colors.grey, fontSize: 18.sp),
                      onPressed: () {
                        context.pushNamed(Routes.logInScreen);
                      },
                      backgroundColor: Colors.transparent,
                      borderSide: const BorderSide(color: Colors.grey),
                      radius: 25.r,
                      child: const Text(
                        "Log In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    verticalSpace(80.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
