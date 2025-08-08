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
            child: Column(
              children: [
                verticalSpace(450.h),
                const CarvOnLogo(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      verticalSpace(50.h),
                      AppButton(
                        buttonHeight: 40.h,

                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        onPressed: () {
                          context.pushNamed(Routes.signUpScreen);
                        },
                        backgroundColor: AppColors.lightBlue,
                        radius: 25,
                        buttonWidth: 280.w,
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      verticalSpace(15.h),
                      AppButton(
                        buttonHeight: 40.h,

                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        onPressed: () {},
                        backgroundColor: Colors.transparent,
                        borderSide: const BorderSide(color: Colors.grey),
                        radius: 25,
                        buttonWidth: 280.w,
                        child: const Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
