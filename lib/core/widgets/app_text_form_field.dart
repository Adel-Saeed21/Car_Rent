import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final double radius;
  final Color focusBorderColor;
  final Color enableBorderColor;
  final bool? isSecure;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? label;
  final TextStyle? labelStyle;
  const AppTextFormField({
    super.key,
    this.hintText,
    this.suffixIcon,
    required this.radius,
    required this.focusBorderColor,
    required this.enableBorderColor,
    this.isSecure,
    this.contentPadding,
    this.textStyle,
    this.backgroundColor,
    this.controller,
    this.validator,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        fillColor: backgroundColor ?? AppColors.lightBlack,
        isDense: true,
        filled: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        enabledBorder: textFiledBorderType(radius, enableBorderColor),
        focusedBorder: textFiledBorderType(radius, focusBorderColor),
        errorBorder: textFiledBorderType(radius, Colors.red),
        focusedErrorBorder: textFiledBorderType(radius, Colors.red),
        border: textFiledBorderType(radius, enableBorderColor),
        // hintStyle: TextStyles.font14LightGreyRegular,
        hintText: hintText,
        suffixIcon: suffixIcon,
        label: label,
        labelStyle: labelStyle,
      ),
      cursorColor: AppColors.lightBlue,

      obscureText: isSecure ?? false,
      style: textStyle,
    );
  }

  OutlineInputBorder textFiledBorderType(double radias, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radias),
      borderSide: BorderSide(color: color, width: 1.3.w),
    );
  }
}
