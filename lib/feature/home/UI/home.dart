import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/home/UI/widgets/category_logo.dart';
import 'package:carrent/feature/home/UI/widgets/home_custom_app_bar.dart';
import 'package:carrent/feature/home/UI/widgets/search_text_field.dart';
import 'package:carrent/feature/home/data/category_logo_model.dart';
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
          child: SingleChildScrollView(
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
                          // Reset categories
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
                // Category List
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
                              selectedCategory ==
                              categoryModel[i].logoTextBrand,
                          isLoading:
                              isLoading &&
                              selectedCategory ==
                                  categoryModel[i].logoTextBrand,
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
                // BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
                //   builder: (context, state) {
                //     return Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16.w),
                //       child: _buildContentContainer(context, state),
                //     );
                //   },
                // ),

              



                verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentContainer(BuildContext context, HomeCategoryState state) {
    final selectedCategory = context.read<HomeCategoryCubit>().currentCategory;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _getBorderColor(state), width: 1),
      ),
      child: Column(
        children: [
          _buildStateIndicator(state),
          verticalSpace(10.h),
          _buildSuccessContent(selectedCategory, state),
        ],
      ),
    );
  }

  Widget _buildStateIndicator(HomeCategoryState state) {
    if (state is HomeCategoryLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16.w,
            height: 16.h,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.blue,
            ),
          ),
          horizontalSpace(10.w),
          Text(
            "Loading cars...",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 16.sp,
              color: Colors.blue,
            ),
          ),
        ],
      );
    }

    return Text(
      "Selected Category:",
      style: AppTextStyle.font20WhiteRgular.copyWith(
        fontSize: 16.sp,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildSuccessContent(
    String selectedCategory,
    HomeCategoryState state,
  ) {
    return Column(
      children: [
        Text(
          selectedCategory,
          style: AppTextStyle.font20WhiteRgular.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.lightBlue,
          ),
        ),
        verticalSpace(15.h),
        Text(
          "Cars available for $selectedCategory",
          style: AppTextStyle.font20WhiteRgular.copyWith(
            fontSize: 14.sp,
            color: Colors.grey[400],
          ),
          textAlign: TextAlign.center,
        ),
        if (state is HomeCategoryChanged) ...[
          verticalSpace(10.h),

          verticalSpace(5.h),
        ],
      ],
    );
  }

  Color _getBorderColor(HomeCategoryState state) {
    if (state is HomeCategoryLoading) {
      return Colors.blue;
    } else if (state is HomeCategoryError) {
      return Colors.red;
    } else if (state is HomeCategoryChanged) {
      return Colors.green;
    }
    return AppColors.lightBlue;
  }
}
