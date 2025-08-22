import 'package:carrent/core/utils/app_assets.dart';

class CategoryLogoModel {
  final String logoAsset;
  final String logoTextBrand;

  CategoryLogoModel({required this.logoAsset, required this.logoTextBrand});
}

List<CategoryLogoModel> categoryModel = [
  CategoryLogoModel(
    logoAsset: Assets.assetsImagesMercedesLogo,
    logoTextBrand: "Mercedes",
  ),
  CategoryLogoModel(
    logoAsset: Assets.assetsImagesBentleyLogo,
    logoTextBrand: "Bentley",
  ),

  CategoryLogoModel(logoAsset: Assets.assetsImagesAudi, logoTextBrand: "Audi"),
  CategoryLogoModel(
    logoAsset: Assets.assetsImagesKIALOGO,
    logoTextBrand: "KIA",
  ),
  CategoryLogoModel(
    logoAsset: Assets.assetsImagesBMWLogo,
    logoTextBrand: "BMW",
  ),
];
