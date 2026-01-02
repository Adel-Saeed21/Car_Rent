import 'package:carrent/core/helpers/extensions.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

 
class CarCardWidget extends StatelessWidget {
  final CarEntity car;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final double? width;

  const CarCardWidget({
    super.key,
    required this.car,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = width ?? MediaQuery.of(context).size.width * 0.9;

    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.carDetails, arguments: car);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        width: screenWidth,
        height: 280.h,
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
               
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.name,
                        style: AppTextStyle.font20WhiteRgular.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(2.h),
                      Text(
                        car.brand,
                        style: AppTextStyle.font20WhiteRgular.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onFavoriteToggle != null)
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: IconButton(
                      onPressed: onFavoriteToggle,
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          key: ValueKey(isFavorite),
                          color: isFavorite
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

             
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: -20,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      car.imageAsset,
                      width: 400.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(10.h),

             
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeature(
                  "${car.maxSpeed}Km/h",
                  MdiIcons.speedometer,
                ),
                _buildFeature(
                  "${car.seats < 10 ? '0${car.seats}' : car.seats} Seats",
                  MdiIcons.carSeat,
                ),
                _buildFeature(
                  "\$${car.pricePerDay}/Day",
                  null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String text, IconData? icon) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: AppColors.lightBlue,
            size: 20.sp,
          ),
          SizedBox(width: 4.w),
        ],
        Text(
          text,
          style: AppTextStyle.font20WhiteRgular.copyWith(
            fontSize: 12.sp,
            color: AppColors.offWhite,
          ),
        ),
      ],
    );
  }
}
