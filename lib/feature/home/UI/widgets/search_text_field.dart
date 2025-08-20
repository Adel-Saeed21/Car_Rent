import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12.w : 16.w),
      child: TextField(
        decoration: InputDecoration(
          fillColor: AppColors.darkGrey,
          filled: true,
          hint: Text(
            "Search",
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),

          border: textFiledBorderType(18.r, AppColors.darkGrey),
          enabledBorder: textFiledBorderType(18.r, AppColors.darkGrey),
          focusedBorder: textFiledBorderType(18.r, AppColors.lightBlue),

          suffixIcon: Icon(Icons.search, size: 25.sp, color: Colors.white70),
        ),
        style: TextStyle(color: AppColors.offWhite),
      ),
    );
  }

  OutlineInputBorder textFiledBorderType(double radias, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radias.r),
      borderSide: BorderSide(color: color),
    );
  }
}
