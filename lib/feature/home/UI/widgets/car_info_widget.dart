import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/home/UI/widgets/car_category_feature.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:carrent/feature/home/logic/home_cubit.dart';
import 'package:carrent/feature/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CarInfoWidget extends StatelessWidget {
  const CarInfoWidget({
    super.key,
    required this.car,
    required this.screenWidth,
  });

  final CarModel car;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
      builder: (context, state) {
        final currentCars = context.read<HomeCategoryCubit>().currentCars;
        final currentCar = currentCars.firstWhere(
          (c) => c.id == car.id,
          orElse: () => car,
        );

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          width: screenWidth,
          height: 280.h,
          decoration: BoxDecoration(
            color: AppColors.darkGrey,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header with car name and favorite button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentCar.name,
                          style: AppTextStyle.font20WhiteRgular.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        verticalSpace(2.h),
                        Text(
                          currentCar.brand,
                          style: AppTextStyle.font20WhiteRgular.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        final wasFavorite = currentCar.isFavorite;

                        context.read<HomeCategoryCubit>().toggleCarFavorite(
                          currentCar.id,
                        );

                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              !wasFavorite
                                  ? '${currentCar.name} added to favorites!'
                                  : '${currentCar.name} removed from favorites!',
                            ),
                            duration: const Duration(milliseconds: 1500),
                            backgroundColor: !wasFavorite
                                ? AppColors.lightBlue
                                : Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.1,
                              left: 20,
                              right: 20,
                            ),
                          ),
                        );
                      },
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          currentCar.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          key: ValueKey(currentCar.isFavorite),
                          color: currentCar.isFavorite
                              ? AppColors.lightBlue
                              : AppColors.offWhite,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              verticalSpace(10.h),

              // Car Image
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: -20,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        currentCar.imageAsset,
                        width: 400.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              verticalSpace(10.h),

              // Car Features
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CarFeatureRow(
                    featureText: "${currentCar.maxSpeed}Km/h",
                    iconData: MdiIcons.speedometer,
                  ),
                  CarFeatureRow(
                    featureText:
                        "${currentCar.seats < 10 ? '0${currentCar.seats}' : currentCar.seats} Seats",
                    iconData: MdiIcons.carSeat,
                  ),
                  const CarFeatureRow(
                    featureText: "\${currentCar.pricePerDay}",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
