import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarFeatureRow extends StatelessWidget {
  const CarFeatureRow({super.key, required this.featureText, this.iconData});
  final String featureText;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      width: 100.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: AppColors.lightBlack,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (iconData != null)
            Icon(iconData, size: 20, color: AppColors.offWhite)
          else
            const SizedBox(width: 20),
          Flexible(
            child: Text(
              featureText,
              style: TextStyle(
                color: AppColors.offWhite,
                fontWeight: FontWeightHelper.bold,
                fontSize: 12.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
