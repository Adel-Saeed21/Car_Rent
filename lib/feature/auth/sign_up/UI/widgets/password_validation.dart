import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialChar,
    required this.hasNumber,
    required this.hasMinLength,
  });

  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialChar;
  final bool hasNumber;
  final bool hasMinLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow('At least 1 lowercase letter', hasLowerCase),
        verticalSpace(2.h),
        buildValidationRow('At least 1 uppercase letter', hasUpperCase),
        verticalSpace(2.h),
        buildValidationRow('At least 1 special letter', hasSpecialChar),
        verticalSpace(2.h),
        buildValidationRow('At least 1 number letter', hasNumber),
        verticalSpace(2.h),
        buildValidationRow('At least 8 character length', hasLowerCase),
        verticalSpace(2.h),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(radius: 2.5, backgroundColor: Colors.grey),
        horizontalSpace(6.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
             
            fontWeight: FontWeightHelper.regular,

            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? Colors.grey : AppColors.lightBlue,
          ),
        ),
      ],
    );
  }
}
