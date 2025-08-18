import 'package:carrent/core/helpers/spacing.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
