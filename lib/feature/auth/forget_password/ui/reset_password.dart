import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/auth/forget_password/ui/widgets/reset_password_form.dart';
import 'package:carrent/feature/auth/sign_up/UI/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: const CustomAppBar(title: "Reset Password"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10.h, right: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Forgot Password?",
                style: AppTextStyle.font20LightBlueRgular.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeightHelper.medium,
                ),
              ),
              const Text(
                "Enter your email and we'll send you a reset link if the account exists",
                style: TextStyle(color: Colors.grey),
              ),
              const ResetPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}