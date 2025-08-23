import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_assets.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/car_Details/test.dart';
import 'package:carrent/feature/car_Details/widgets/specification_car_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  double rotationAngle = 0.0;
  bool isModelLoaded = false;
  bool showModel = false;

  late List<SpecificationData> carSpecifications;

  @override
  void initState() {
    super.initState();
    _initializeSpecifications();
  }

  void _initializeSpecifications() {
    carSpecifications = [
      SpecificationData(
        icon: MdiIcons.speedometer,
        iconColor: Colors.cyan,
        title: "Top Speed",
        value: "250 km/h",
      ),
      SpecificationData(
        icon: MdiIcons.battery,
        iconColor: Colors.green,
        title: "Range",
        value: "520 km",
      ),
      SpecificationData(
        icon: MdiIcons.rocketLaunch,
        iconColor: Colors.orange,
        title: "0-100 km/h",
        value: "3.2 sec",
      ),
      SpecificationData(
        icon: MdiIcons.seatReclineNormal,
        iconColor: Colors.blue,
        title: "Seats",
        value: "5 Seats",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: Column(
        children: [
          // Custom AppBar
          const CarDetailsAppBar(),

          // Car Showcase Widget
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: AppColors.lightBlack,
              child: Center(
                child: CarShowcaseWidget(
                  carImageUrl: Assets.assetsImagesCar1,
                  width: 350.w,
                  height: 250.h,
                  backgroundColor: AppColors.lightBlack,
                  glowColor: Colors.cyan,
                  platformColor: Colors.white,
                ),
              ),
            ),
          ),

          // Car Info Section
          CarDetailsWidget(specifications: carSpecifications),
        ],
      ),
    );
  }
}

class CarDetailsWidget extends StatelessWidget {
  final List<SpecificationData> specifications;

  const CarDetailsWidget({super.key, required this.specifications});

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
    final features = [
      "Autopilot",
      "Supercharging",
      "Premium Interior",
      "Advanced Safety",
    ];

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
                  "Rent Now - \$85/day",
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

class CarDetailsAppBar extends StatelessWidget {
  const CarDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBlack,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: AppColors.offWhite,
                    ),
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.offWhite,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Text(
                "Car Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.offWhite,
                  fontSize: 22,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.offWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
