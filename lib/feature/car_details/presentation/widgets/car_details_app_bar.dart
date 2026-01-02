import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarDetailsAppBar extends StatelessWidget {
  final CarEntity car;
  final String userId;

  const CarDetailsAppBar({
    super.key,
    required this.car,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBlack,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                      color: AppColors.offWhite,
                    ),
                    Text(
                      "Back",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.offWhite,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),

               
              Text(
                "Car Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.offWhite,
                  fontSize: 20.sp,
                ),
              ),

               
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    bool isFavorite = false;
                    if (state is FavoriteLoaded) {
                      isFavorite = state.favoriteCars.any((c) => c.id == car.id);
                    } else if (state is FavoriteToggled && state.carId == car.id) {
                      isFavorite = state.isFavorite;
                    }

                    return IconButton(
                      onPressed: () {
                         context.read<FavoriteCubit>().toggleFavorite(userId, car.id);
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
                          size: 20.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
