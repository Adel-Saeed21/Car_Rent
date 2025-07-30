import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/onBoarding/UI/widget/custom_smooth_page_indecator.dart';
import 'package:carrent/feature/onBoarding/data/onbording_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnbordingWidgetView extends StatelessWidget {
  const OnbordingWidgetView({
    super.key,
    required this.pageController,
    required this.index,
    required this.onboarding,
    this.onPageChanged,
  });

  final void Function(int)? onPageChanged;
  final PageController pageController;
  final int index;
  final OnbordingModel onboarding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      children: [
        Positioned(
          top: onboarding.topPos ?? 60.h,
          right: onboarding.rightPos ?? 5.w,

          child: Image.asset(
            onboarding.imagePath,
            height: onboarding.size ?? 250.h,
            fit: BoxFit.contain,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 300.h, right: 10.w, left: 10.w),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  onboarding.title,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.font30WhiteBold,
                ),
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  onboarding.subTitle,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ),
              verticalSpace(12.h),
              CustomSmoothPageIndicator(controller: pageController),
            ],
          ),
        ),
      ],
    );
  }
}
