import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_assets.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/FeedBack/Logic/feedback_cubit.dart';
import 'package:carrent/feature/FeedBack/data/Repos/feedback_repo.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => FeedbackCubit(FeedbackRepository()),
      child: Scaffold(
        backgroundColor: AppColors.lightBlack,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Feedback",
                      style: AppTextStyle.font20WhiteRgular,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(10.h),
                      CarCardFeedBack(screenWidth: screenWidth),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CarCardFeedBack extends StatelessWidget {
  const CarCardFeedBack({
    super.key,
    required this.screenWidth,
    this.car,
    this.rating = 4.5,
    this.reviewCount = 128,
    this.onFeedbackTap,
    this.onCardTap,
  });

  final double screenWidth;
  final CarModel? car;
  final double rating;
  final int reviewCount;
  final VoidCallback? onFeedbackTap;
  final VoidCallback? onCardTap;

  @override
  Widget build(BuildContext context) {
    final carName = car?.name ?? "AMG GT";
    final carBrand = car?.brand ?? "Mercedes";
    final carImage = car?.imageAsset ?? Assets.assetsImagesCar1;

    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        width: screenWidth,
        height: 300.h,
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: AppColors.lightBlue.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row
            Row(
              children: [
                // Car Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        carName,
                        style: AppTextStyle.font20WhiteRgular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      verticalSpace(4.h),
                      Row(
                        children: [
                          Text(
                            carBrand,
                            style: AppTextStyle.font20WhiteRgular.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.lightBlue,
                              fontWeight: FontWeightHelper.medium,
                            ),
                          ),
                          horizontalSpace(8.w),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < rating.floor()
                                    ? Icons.star
                                    : index < rating
                                    ? Icons.star_half
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 14.sp,
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.lightBlue.withOpacity(0.2),
                        AppColors.lightBlue.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.lightBlue.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap:
                          onFeedbackTap ??
                          () => _showFeedbackBottomSheet(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.rate_review_outlined,
                              color: AppColors.lightBlue,
                              size: 16.sp,
                            ),
                            horizontalSpace(6.w),
                            Text(
                              "Feedback",
                              style: TextStyle(
                                color: AppColors.lightBlue,
                                fontWeight: FontWeightHelper.medium,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            verticalSpace(15.h),

            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            AppColors.lightBlue.withOpacity(0.05),
                            Colors.transparent,
                          ],
                          center: Alignment.center,
                          radius: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      carImage,
                      width: 380.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(12.h),

            // Rating Section محسن
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.lightBlack.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.amber.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating.floor()
                                ? Icons.star
                                : index < rating
                                ? Icons.star_half
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 18.sp,
                          );
                        }),
                      ),
                      horizontalSpace(8.w),
                      Text(
                        rating.toStringAsFixed(1),
                        style: AppTextStyle.font20WhiteRgular.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),

                  // Review Count
                  Text(
                    "($reviewCount reviews)",
                    style: AppTextStyle.font20WhiteRgular.copyWith(
                      color: AppColors.offWhite.withOpacity(0.7),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedbackBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.offWhite.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              verticalSpace(20.h),

              // Title
              Text(
                "Customer Feedback",
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              verticalSpace(16.h),

              // Sample Reviews
              Expanded(
                child: ListView(
                  children: [
                    _buildReviewItem(
                      "John D.",
                      5,
                      "Amazing car! Very comfortable and powerful.",
                      "2 days ago",
                    ),
                    verticalSpace(12.h),
                    _buildReviewItem(
                      "Sarah M.",
                      4,
                      "Great experience, would rent again.",
                      "1 week ago",
                    ),
                    verticalSpace(12.h),
                    _buildReviewItem(
                      "Ahmed K.",
                      5,
                      "Perfect for weekend trips!",
                      "2 weeks ago",
                    ),
                  ],
                ),
              ),
              _buildFeedbackInput(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewItem(String name, int stars, String review, String date) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.lightBlack.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.lightBlue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
              Text(
                date,
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.offWhite.withOpacity(0.6),
                ),
              ),
            ],
          ),
          verticalSpace(4.h),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < stars ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 14.sp,
              );
            }),
          ),
          verticalSpace(6.h),
          Text(
            review,
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 13.sp,
              color: AppColors.offWhite.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
  // استبدال الـ TextField الحالي بهذا التصميم المُحسن

  Widget _buildFeedbackInput(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.lightBlue.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightBlue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Rating Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.darkGrey.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Rate your experience:",
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.offWhite,
                  ),
                ),
                horizontalSpace(12.w),
                Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle rating tap
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Icon(
                          Icons.star_border,
                          color: Colors.amber,
                          size: 20.sp,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          // Text Input
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                TextField(
                  controller: feedbackController,
                  maxLines: 4,
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Share your experience with this car...",
                    hintStyle: AppTextStyle.font20WhiteRgular.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.offWhite.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.darkGrey.withOpacity(0.3),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                ),

                verticalSpace(12.h),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: AppColors.darkGrey,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.lightBlue.withOpacity(0.3),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: AppTextStyle.font20WhiteRgular.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.offWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    horizontalSpace(12.w),

                    Expanded(
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.lightBlue,
                              AppColors.lightBlue.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightBlue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: () {
                              _submitFeedback(context, feedbackController.text);
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                  horizontalSpace(8.w),
                                  Text(
                                    "Submit",
                                    style: AppTextStyle.font20WhiteRgular
                                        .copyWith(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeightHelper.medium,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitFeedback(BuildContext context, String feedback) {
    if (feedback.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please write your feedback first"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            horizontalSpace(8.w),
            Text("Thank you for your feedback!"),
          ],
        ),
        backgroundColor: AppColors.lightBlue,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );

    Navigator.pop(context);
  }
}
