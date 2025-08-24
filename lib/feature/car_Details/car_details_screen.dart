import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/car_Details/test.dart';
import 'package:carrent/feature/car_Details/widgets/car_details_widget.dart';
import 'package:carrent/feature/car_Details/widgets/car_detais_app_bar.dart';
import 'package:carrent/feature/car_Details/widgets/specification_car_widget.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key, required this.carModel});
  final CarModel carModel;

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
                  carImageUrl: widget.carModel.imageAsset,
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
          CarDetailsWidget(
            specifications:
                widget.carModel.carDataSpecification ?? carSpecifications,
            features: widget.carModel.features,
            price: widget.carModel.pricePerDay,
          ),
        ],
      ),
    );
  }
}
