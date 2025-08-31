import 'package:carrent/core/helpers/extensions.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/auth/log_in/UI/widgets/log_in_form.dart';
import 'package:carrent/feature/auth/log_in/UI/widgets/social_login_buttons.dart';
import 'package:carrent/feature/auth/sign_up/UI/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: const CustomAppBar(title: "Log in"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(20.h),

                // // Logo
                // CarvOnLogo(color: AppColors.lightBlue),
                verticalSpace(30.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color: AppColors.lightBlue,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(5.h),
                      Text(
                        "Please log in to continue",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                verticalSpace(10.h),

                // Login Form
                const LogInForm(),

                verticalSpace(25.h),

                

                // Social Login Buttons
                const SocialLoginButtons(),

                verticalSpace(30.h),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushReplacmentNamed(Routes.signUpScreen);
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: AppColors.lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
