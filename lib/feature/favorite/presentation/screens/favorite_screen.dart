import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/functions/is_user_login.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_state.dart';
import 'package:carrent/feature/favorite/presentation/widgets/empty_favorites_widget.dart';
import 'package:carrent/feature/car/presentation/widgets/car_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<FavoriteCubit>()..loadFavorites(getUserId()),
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        appBar: AppBar(
          backgroundColor: AppColors.darkBlack,
          elevation: 0,
          title: Text(
            'My Favorites',
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.lightBlue,
                ),
              );
            }

            if (state is FavoriteError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error',
                      style: AppTextStyle.font20WhiteRgular.copyWith(
                        fontSize: 20.sp,
                        color: Colors.red,
                      ),
                    ),
                    verticalSpace(10.h),
                    Text(
                      state.message,
                      style: AppTextStyle.font20WhiteRgular.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.offWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (state is FavoriteEmpty) {
              return const EmptyFavoritesWidget();
            }

            if (state is FavoriteLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<FavoriteCubit>().loadFavorites(getUserId());
                },
                color: AppColors.lightBlue,
                backgroundColor: AppColors.darkGrey,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  itemCount: state.favoriteCars.length,
                  itemBuilder: (context, index) {
                    final car = state.favoriteCars[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: CarCardWidget(
                        car: car,
                        isFavorite: true,
                        onFavoriteToggle: () {
                          context.read<FavoriteCubit>().removeFavorite(
                                getUserId(),
                                car.id,
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${car.name} removed from favorites!',
                              ),
                              duration: const Duration(milliseconds: 1500),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }

            return const EmptyFavoritesWidget();
          },
        ),
      ),
    );
  }

   
  String getUserId() {
    return getUserEmail() ?? 'default_user';
  }
}
