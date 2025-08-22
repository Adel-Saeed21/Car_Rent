import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryLogo extends StatelessWidget {
  const CategoryLogo({
    super.key,
    required this.isSmallScreen,
    required this.imageAssets,
    required this.logoName,
    required this.isSelected,
    required this.onTap,
    this.isLoading = false,
  });

  final bool isSmallScreen;
  final String imageAssets;
  final String logoName;
  final bool isSelected;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isSmallScreen ? 90.w : 110.w,
        height: 110.h,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: _getBorderColor(), width: 2),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppColors.lightBlue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            verticalSpace(isSmallScreen ? 10.h : 12.h),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 55.w,
              height: 55.h,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(),
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : AnimatedScale(
                        scale: isSelected ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Image.asset(
                          imageAssets,
                          width: 30.w,
                          height: 30.h,
                          fit: BoxFit.contain,
                          color: isSelected ? Colors.white : null,
                        ),
                      ),
              ),
            ),
            verticalSpace(isSmallScreen ? 8.h : 10.h),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 15.sp,
                color: _getTextColor(),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(logoName, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (isLoading) {
      // ignore: deprecated_member_use
      return AppColors.lightBlue.withOpacity(0.2);
    } else if (isSelected) {
      // ignore: deprecated_member_use
      return AppColors.lightBlue.withOpacity(0.2);
    }
    return AppColors.darkGrey;
  }

  Color _getBorderColor() {
    if (isLoading) {
      return Colors.blue;
    } else if (isSelected) {
      return AppColors.lightBlue;
    }
    return Colors.transparent;
  }

  Color _getIconBackgroundColor() {
    if (isLoading) {
      return Colors.blue;
    } else if (isSelected) {
      return AppColors.lightBlue;
    }
    return Colors.white;
  }

  Color _getTextColor() {
    if (isLoading) {
      return Colors.blue;
    } else if (isSelected) {
      return AppColors.lightBlue;
    }
    return Colors.white;
  }
}
