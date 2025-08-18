import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_assets.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/home/UI/widgets/home_custom_app_bar.dart';
import 'package:carrent/feature/home/UI/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12.w : 16.w,
            vertical: 8.h,
          ),
          child: Column(
            children: [
              const HomeCustomAppBar(),
              verticalSpace(22.h),
              const SearchTextField(),
              verticalSpace(22.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category", style: AppTextStyle.font20WhiteRgular),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See All",
                      style: AppTextStyle.font20WhiteRgular.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                child: Container(
                  width: isSmallScreen ? 90.w : 110.w,
                  height: 110.h,
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      verticalSpace(8.h),
                      Container(
                        width: 55.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Image.asset(
                          Assets.assetsImagesBMWLogo,
                          fit: BoxFit.contain,
                          width: 30.w,
                          height: 30.w,
                        ),
                      ),
                    ],
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
