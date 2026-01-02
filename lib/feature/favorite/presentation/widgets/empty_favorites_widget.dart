import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

 
class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            MdiIcons.heartOutline,
            size: 100.sp,
             
            color: AppColors.lightBlue.withOpacity(0.3),
          ),
          verticalSpace(20.h),
          Text(
            'No Favorites Yet',
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              'Start adding cars to your favorites by tapping the heart icon on any car',
              textAlign: TextAlign.center,
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 14.sp,
                color: AppColors.offWhite.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
