import 'package:carrent/core/helpers/extensions.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/home/UI/widgets/car_category_feature.dart';
import 'package:carrent/feature/home/logic/home_cubit.dart';
import 'package:carrent/feature/home/logic/home_state.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_state.dart';
import 'package:carrent/core/functions/is_user_login.dart';
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

  final CarEntity car;
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

                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, favState) {
                        bool isFavorite = false;
                        if (favState is FavoriteLoaded) {
                          isFavorite = favState.favoriteCars
                              .any((c) => c.id == currentCar.id);
                        }
                         
                         

                        return Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: IconButton(
                            onPressed: () {
                              final userId = getUserEmail() ?? 'default_user';
                              context
                                  .read<FavoriteCubit>()
                                  .toggleFavorite(userId, currentCar.id);
                            },
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
                        );
                      },
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
                          currentCar.imageAsset,
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
                    CarFeatureRow(
                      featureText: "${currentCar.maxSpeed}Km/h",
                      iconData: MdiIcons.speedometer,
                    ),
                    CarFeatureRow(
                      featureText:
                          "${currentCar.seats < 10 ? '0${currentCar.seats}' : currentCar.seats} Seats",
                      iconData: MdiIcons.carSeat,
                    ),
                    CarFeatureRow(
                      featureText: "\$${currentCar.pricePerDay}/Day",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
