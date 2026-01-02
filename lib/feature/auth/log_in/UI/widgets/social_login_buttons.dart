import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/auth/log_in/UI/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(thickness: 1, color: AppColors.lightBlue)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("or", style: TextStyle(color: AppColors.lightBlue)),
            ),
            Expanded(child: Divider(thickness: 1, color: AppColors.lightBlue)),
          ],
        ),
        verticalSpace(20.h),

         
        SocialButton(
          text: "Sign up with Google",
          icon: Image.asset("assets/icons/google.png", height: 20, width: 20),
          onPressed: () {},
        ),
        verticalSpace(12.h),

         
        SocialButton(
          text: "Sign up with FaceBook",
          icon: Image.asset("assets/icons/faceBook.png", height: 20, width: 20),
          onPressed: () {},
        ),
      ],
    );
  }
}
