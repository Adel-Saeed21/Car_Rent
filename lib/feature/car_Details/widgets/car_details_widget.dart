import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/car_Details/widgets/specification_car_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarDetailsWidget extends StatelessWidget {
  final List<SpecificationData> specifications;
  final List<String> features;
  final String price;
  const CarDetailsWidget({
    super.key,
    required this.specifications,
    required this.features, required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Title and Description
              Text(
                "Tesla Model",
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontWeight: FontWeightHelper.bold,
                  fontSize: 25,
                ),
              ),
              verticalSpace(8.h),
              Text(
                "This car made by Tesla and it more comfortable",
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  color: AppColors.offWhite,
                  fontSize: 14,
                ),
              ),
              verticalSpace(20.h),

              SpecificationGrid(
                specifications: specifications,
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
              ),

              verticalSpace(20.h),

              _buildAdditionalFeatures(),

              verticalSpace(20.h),

              _buildRentButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalFeatures() {
    // final features = [
    //   "Autopilot",
    //   "Supercharging",
    //   "Premium Interior",
    //   "Advanced Safety",
    // ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Features",
          style: AppTextStyle.font20WhiteRgular.copyWith(
            fontWeight: FontWeightHelper.bold,
            fontSize: 18,
          ),
        ),
        verticalSpace(12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: features.map((feature) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.lightBlack,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.cyan.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                feature,
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.offWhite,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRentButton() {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.cyan, Colors.blue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // Handle rent action
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.car_rental, color: Colors.white, size: 20.sp),
                horizontalSpace(8.w),
                Text(
                  "Rent Now - \$",
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeightHelper.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
