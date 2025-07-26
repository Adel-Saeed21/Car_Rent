import 'package:carrent/core/utils/app_assets.dart';

class OnbordingModel {
  final String imagePath;
  final String title;
  final String subTitle;

  OnbordingModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });
}

List<OnbordingModel> onboardingList = [
  OnbordingModel(
    imagePath: Assets.assetsImagesCarOnboarding,
    title: "Luxury Cars Rental in\nnew York",
    subTitle:
        "Rent a Car online Today & Enjoy the Best Deals,\nRates & Accessories.",
  ),
  OnbordingModel(
    imagePath: Assets.assetsImagesCarOnboarding,
    title: "Luxury Cars Rental in\nnew York",
    subTitle:
        'Rent a Car online Today & Enjoy the Best Deals,\nRates & Accessories',
  ),
  OnbordingModel(
    imagePath: Assets.assetsImagesCarOnboarding,
    title: 'Luxury Cars Rental in\nnew York',
    subTitle:
        'Rent a Car online Today & Enjoy the Best Deals,\nRates & Accessories',
  ),
];
