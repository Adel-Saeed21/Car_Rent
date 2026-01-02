import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/car/data/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecificationCardWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final double? width;
  final double? height;

  const SpecificationCardWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      width: width,
      height: height ?? 121.h,
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 28.sp, color: iconColor),
          ),

           
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.offWhite,
                ),
              ),
              verticalSpace(4.h),
              Text(
                value,
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

 
class SpecificationGrid extends StatelessWidget {
  final List<SpecificationDataModel> specifications;
  final int crossAxisCount;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;

  const SpecificationGrid({
    super.key,
    required this.specifications,
    this.crossAxisCount = 2,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < specifications.length; i += crossAxisCount)
          Padding(
            padding: EdgeInsets.only(
              bottom: i + crossAxisCount < specifications.length
                  ? (mainAxisSpacing ?? 12.h)
                  : 0,
            ),
            child: Row(
              children: [
                for (
                  int j = 0;
                  j < crossAxisCount && i + j < specifications.length;
                  j++
                )
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right:
                            j < crossAxisCount - 1 &&
                                i + j + 1 < specifications.length
                            ? (crossAxisSpacing ?? 12.w)
                            : 0,
                      ),
                      child: SpecificationCardWidget(
                        icon: specifications[i + j].icon,
                        iconColor: specifications[i + j].iconColor,
                        title: specifications[i + j].title,
                        value: specifications[i + j].value,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
