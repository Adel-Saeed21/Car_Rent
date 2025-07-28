import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  const CustomSmoothPageIndicator({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _controller,
      count: 3,
      effect: JumpingDotEffect(
        jumpScale: 1.5,
        dotWidth: 10,
        dotHeight: 10,
        verticalOffset: 10,
        dotColor: Colors.grey,
        activeDotColor: AppColors.lightBlue,
      ),
    );
  }
}
