import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final bool isSmallScreen;
  final bool isSearchMode;
  final bool isSearchLoading;
  final VoidCallback onClear;

  const SearchField({
    super.key,
    required this.controller,
    required this.isSmallScreen,
    required this.isSearchMode,
    required this.isSearchLoading,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12.w : 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: isSearchMode
              ? [
                  BoxShadow(
                    color: AppColors.lightBlue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(color: AppColors.offWhite, fontSize: 16.sp),
          decoration: InputDecoration(
            fillColor: isSearchMode
                ? AppColors.darkGrey.withOpacity(0.9)
                : AppColors.darkGrey,
            filled: true,
            hintText: isSearchMode ? "Searching" : "search",
            hintStyle: TextStyle(
              color: isSearchMode ? AppColors.lightBlue : Colors.white70,
              fontSize: 15.sp,
            ),
            border: _textFieldBorderType(18.r, AppColors.darkGrey),
            enabledBorder: _textFieldBorderType(
              18.r,
              isSearchMode
                  ? AppColors.lightBlue.withOpacity(0.5)
                  : AppColors.darkGrey,
            ),
            focusedBorder: _textFieldBorderType(18.r, AppColors.lightBlue),

            prefixIcon: isSearchLoading
                ? Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        color: AppColors.lightBlue,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Icon(
                    Icons.search,
                    size: 22.sp,
                    color: isSearchMode ? AppColors.lightBlue : Colors.white70,
                  ),

            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    onPressed: onClear,
                    icon: Icon(Icons.close, size: 20.sp, color: Colors.white70),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _textFieldBorderType(double radius, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }
}
