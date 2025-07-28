import 'package:carrent/core/utils/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnbordingModel {
  final String imagePath;
  final String title;
  final String subTitle;
  final double? rightPos;
  final double? leftPos;
  final double? topPos;
  final double? size;

  OnbordingModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
    this.rightPos,
    this.leftPos,
    this.topPos,
    this.size,
  });
}

List<OnbordingModel> onboardingList = [
  OnbordingModel(
    imagePath: Assets.assetsImagesCarOnboarding,
    title: "Luxury Cars Rental in\nnew York",
    subTitle:
        "Rent a Car online Today & Enjoy the Best Deals,\nRates & Accessories.",
    topPos: 50.h,
    rightPos: -70,
    size: 310.h,
  ),
  OnbordingModel(
    imagePath: Assets.assetsImagesOnboardingCar2,
    title: "Luxury Cars Rental in\nnew York",
    subTitle:
        "Choose from a wide range of luxury vehicles\nwith flexible rental options.",
  ),
  OnbordingModel(
    size: 330.h,
    topPos: 30.h,

    rightPos: -190,
    imagePath: Assets.assetsImagesOnboardingCar3,
    title: 'Luxury Cars Rental in\nnew York',
    subTitle:
        "Experience comfort and style on every ride\nwith our premium fleet.",
  ),
];
