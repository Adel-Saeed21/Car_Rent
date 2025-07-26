import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/onBoarding/UI/widget/onbording_widget_view.dart';
import 'package:carrent/feature/onBoarding/data/onbording_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: Column(
        children: [
          verticalSpace(30.h),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onboardingList.length,
              onPageChanged: (i) {
                setState(() {
                  index = i;
                });
              },
              itemBuilder: (context, i) => OnbordingWidgetView(
                pageController: pageController,
                index: i,
                onboarding: onboardingList[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
