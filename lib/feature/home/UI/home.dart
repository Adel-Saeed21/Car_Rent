import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/home/UI/widgets/car_info_widget.dart';
import 'package:carrent/feature/home/UI/widgets/category_logo.dart';
import 'package:carrent/feature/home/UI/widgets/home_custom_app_bar.dart';
import 'package:carrent/feature/home/UI/widgets/search_text_field.dart';
import 'package:carrent/feature/home/data/category_logo_model.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:carrent/feature/home/logic/home_cubit.dart';
import 'package:carrent/feature/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return BlocProvider(
      create: (context) => HomeCategoryCubit(),
      child: Scaffold(
        backgroundColor: AppColors.lightBlack,
        body: SafeArea(
          child: Column(
            children: [
              const HomeCustomAppBar(),
              verticalSpace(22.h),
              const SearchTextField(),
              verticalSpace(22.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 12.w : 16.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category", style: AppTextStyle.font20WhiteRgular),
                    TextButton(
                      onPressed: () {
                        context.read<HomeCategoryCubit>().resetToDefault();
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyle.font20WhiteRgular.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Category List - Fixed
              BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
                builder: (context, state) {
                  final selectedCategory = context
                      .read<HomeCategoryCubit>()
                      .currentCategory;
                  final isLoading = state is HomeCategoryLoading;

                  return SizedBox(
                    height: 110.h,
                    width: screenWidth,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(right: 16.w, left: 10.w),
                      itemCount: categoryModel.length,
                      itemBuilder: (context, i) => CategoryLogo(
                        isSmallScreen: isSmallScreen,
                        imageAssets: categoryModel[i].logoAsset,
                        logoName: categoryModel[i].logoTextBrand,
                        isSelected:
                            selectedCategory == categoryModel[i].logoTextBrand,
                        isLoading:
                            isLoading &&
                            selectedCategory == categoryModel[i].logoTextBrand,
                        onTap: () {
                          context.read<HomeCategoryCubit>().selectCategory(
                            categoryModel[i].logoTextBrand,
                          );
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          horizontalSpace(10.w),
                    ),
                  );
                },
              ),

              verticalSpace(20.h),

              Expanded(
                child: BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
                  builder: (context, state) {
                    final selectedCategory = context
                        .read<HomeCategoryCubit>()
                        .currentCategory;
                    final cars = getCarsByBrand(selectedCategory);

                    if (state is HomeCategoryLoading) {
                      return _buildLoadingState();
                    }

                    if (state is HomeCategoryError) {
                      return _buildErrorState(state.errorMessage, context);
                    }

                    if (cars.isEmpty) {
                      return _buildEmptyState(selectedCategory);
                    }

                    return _buildCarsList(cars, screenWidth);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.lightBlue, strokeWidth: 3),
          verticalSpace(20.h),
          Text(
            "Loading cars...",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 18.sp,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage, BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 60.sp),
            verticalSpace(20.h),
            Text(
              "Something went wrong",
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 18.sp,
                color: Colors.red,
              ),
            ),
            verticalSpace(10.h),
            Text(
              errorMessage,
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String selectedCategory) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            color: Colors.grey[400],
            size: 60.sp,
          ),
          verticalSpace(20.h),
          Text(
            "No cars available",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 18.sp,
              color: Colors.grey[400],
            ),
          ),
          verticalSpace(10.h),
          Text(
            "No cars found for $selectedCategory",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarsList(List<CarModel> cars, double screenWidth) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return CarInfoWidget(car: cars[index], screenWidth: screenWidth);
      },
      separatorBuilder: (context, index) => verticalSpace(16.h),
    );
  }
}
