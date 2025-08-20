import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/home/UI/widgets/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCustomAppBar extends StatelessWidget {
  const HomeCustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12.w : 16.w,
        vertical: 8.h,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: isSmallScreen ? 40.w : 45.w,
              height: isSmallScreen ? 40.h : 45.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  "assets/images/adool.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            horizontalSpace(isSmallScreen ? 8.w : 12.w),

            const Expanded(child: LocationWidget()),

            horizontalSpace(8.w),

            // Notification Icon
            Container(
              width: isSmallScreen ? 35.w : 40.w,
              height: isSmallScreen ? 35.h : 40.h,
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(
                  isSmallScreen ? 17.5.r : 20.r,
                ),
              ),
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.white70,
                size: isSmallScreen ? 20.sp : 22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
