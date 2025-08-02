import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/core/widgets/app_button.dart';
import 'package:carrent/feature/auth/sign_up/UI/widgets/already_have_an_account.dart';
import 'package:carrent/feature/auth/sign_up/UI/widgets/custom_app_bar.dart';
import 'package:carrent/feature/auth/sign_up/UI/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              verticalSpace(10.h),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Create Account",
                  style: AppTextStyle.font24LightBlueBold,
                ),
              ),
              Text(
                'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeightHelper.regular,
                  fontSize: 14.sp,
                ),
              ),
              SignUpForm(),
              verticalSpace(12.h),
              AppButton(
                buttonHeight: 40.h,

                buttonText: "Create Account",
                textStyle: TextStyle(color: Colors.white),
                onPressed: () {
                  //validateThenDoSignup(context);
                },
              ),
              verticalSpace(10.h),
              AlreadyHaveAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
