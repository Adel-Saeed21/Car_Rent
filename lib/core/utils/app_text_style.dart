import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle font30WhiteBold = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
    height: 1.4,
  );

  static TextStyle font24LightBlueBold = TextStyle(
    color: AppColors.lightBlue,
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font20LightBlueRgular = TextStyle(
    fontSize: 15.sp,
    color: AppColors.lightBlue,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font20WhiteRgular = TextStyle(
    fontWeight: FontWeightHelper.regular,
    fontSize: 20.sp,
    color: Colors.white,
  );
}
