// ignore_for_file: deprecated_member_use

import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/FeedBack/Logic/feedback_cubit.dart';
import 'package:carrent/feature/FeedBack/Logic/feedback_state.dart';
import 'package:carrent/feature/FeedBack/data/feedback_model.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'package:carrent/core/di/di.dart'; // إضافة import للـ GetIt

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  UserData? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var box = await Hive.openBox<UserData>('UserDataBox');
    setState(() {
      userData = box.get('currentUser');
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    
    return FutureBuilder<FeedbackCubit>(
      future: getit.getAsync<FeedbackCubit>(), // استخدام GetIt للحصول على FeedbackCubit
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.lightBlack,
            body: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppColors.lightBlack,
            body: Center(
              child: Text(
                'Error loading feedback: ${snapshot.error}',
                style: AppTextStyle.font20WhiteRgular.copyWith(color: Colors.red),
              ),
            ),
          );
        }

        return BlocProvider.value(
          value: snapshot.data!..loadBookedCars(), // تحميل البيانات بعد التأكد من التهيئة
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
                    Expanded(
                      child: BlocBuilder<FeedbackCubit, FeedbackState>(
                        builder: (context, state) {
                          if (state is FeedbackLoading) {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.white),
                            );
                          }
                          
                          if (state is FeedbackError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 48.sp,
                                  ),
                                  verticalSpace(16.h),
                                  Text(
                                    state.error,
                                    style: AppTextStyle.font20WhiteRgular.copyWith(
                                      color: Colors.red,
                                      fontSize: 16.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }

                          if (state is BookedCarsLoaded) {
                            if (state.bookedCars.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.car_rental,
                                      color: AppColors.offWhite.withOpacity(0.5),
                                      size: 64.sp,
                                    ),
                                    verticalSpace(16.h),
                                    Text(
                                      "No booked cars yet",
                                      style: AppTextStyle.font20WhiteRgular.copyWith(
                                        color: AppColors.offWhite.withOpacity(0.7),
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    verticalSpace(8.h),
                                    Text(
                                      "Book a car to leave feedback",
                                      style: AppTextStyle.font20WhiteRgular.copyWith(
                                        color: AppColors.offWhite.withOpacity(0.5),
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.only(top: 10.h),
                              itemCount: state.bookedCars.length,
                              itemBuilder: (context, index) {
                                final feedbackModel = state.bookedCars[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: CarCardFeedBack(
                                    screenWidth: screenWidth,
                                    feedbackModel: feedbackModel,
                                    userData: userData,
                                  ),
                                );
                              },
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CarCardFeedBack extends StatelessWidget {
  const CarCardFeedBack({
    super.key,
    required this.screenWidth,
    required this.feedbackModel,
    this.userData,
    this.onCardTap,
  });

  final double screenWidth;
  final FeedbackModel feedbackModel;
  final UserData? userData;
  final VoidCallback? onCardTap;

  @override
  Widget build(BuildContext context) {
    final hasRatings = feedbackModel.feedbacks.isNotEmpty;
    final averageRating = hasRatings ? feedbackModel.averageRating : 0.0;
    final reviewCount = feedbackModel.totalReviews;

    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        width: screenWidth,
        height: hasRatings ? 320.h : 280.h, 
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
                        feedbackModel.carName,
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
                            feedbackModel.carBrand,
                            style: AppTextStyle.font20WhiteRgular.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.lightBlue,
                              fontWeight: FontWeightHelper.medium,
                            ),
                          ),
                          if (hasRatings) ...[
                            horizontalSpace(8.w),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < averageRating.floor()
                                      ? Icons.star
                                      : index < averageRating
                                      ? Icons.star_half
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 14.sp,
                                );
                              }),
                            ),
                          ],
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
                      onTap: () => _showFeedbackBottomSheet(context),
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
                      feedbackModel.carImage,
                      width: 380.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(12.h),

            // Show rating container only if there are ratings
            if (hasRatings) ...[
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
                              index < averageRating.floor()
                                  ? Icons.star
                                  : index < averageRating
                                  ? Icons.star_half
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 18.sp,
                            );
                          }),
                        ),
                        horizontalSpace(8.w),
                        Text(
                          averageRating.toStringAsFixed(1),
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
            ] else ...[
              // Show "No ratings yet" message
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.lightBlack.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.offWhite.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "No ratings yet - Be the first to rate!",
                    style: AppTextStyle.font20WhiteRgular.copyWith(
                      color: AppColors.offWhite.withOpacity(0.7),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ],
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
        height: MediaQuery.of(context).size.height * 0.7,
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
                "${feedbackModel.carName} - Feedback",
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              verticalSpace(16.h),

              // Real Reviews from Hive
              Expanded(
                child: feedbackModel.feedbacks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.rate_review_outlined,
                              color: AppColors.offWhite.withOpacity(0.5),
                              size: 48.sp,
                            ),
                            verticalSpace(16.h),
                            Text(
                              "No feedback yet",
                              style: AppTextStyle.font20WhiteRgular.copyWith(
                                color: AppColors.offWhite.withOpacity(0.7),
                                fontSize: 16.sp,
                              ),
                            ),
                            verticalSpace(8.h),
                            Text(
                              "Be the first to share your experience!",
                              style: AppTextStyle.font20WhiteRgular.copyWith(
                                color: AppColors.offWhite.withOpacity(0.5),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: feedbackModel.feedbacks.length,
                        itemBuilder: (context, index) {
                          final feedback = feedbackModel.feedbacks[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _buildReviewItem(
                              feedback.userName,
                              feedback.rating.toInt(),
                              feedback.comment,
                              feedback.formattedDate,
                            ),
                          );
                        },
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
              Text(            // Show rating container only if there are ratings

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

  Widget _buildFeedbackInput(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();
    int selectedRating = 0;

    return StatefulBuilder(
      builder: (context, setState) {
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
                            setState(() {
                              selectedRating = index + 1;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Icon(
                              index < selectedRating ? Icons.star : Icons.star_border,
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
                                  _submitFeedback(
                                    context,
                                    feedbackController.text,
                                    selectedRating,
                                  );
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
      },
    );
  }

  void _submitFeedback(BuildContext context, String feedback, int rating) {
    if (feedback.trim().isEmpty || rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            rating == 0 
              ? "Please select a rating first"
              : "Please write your feedback first"
          ),
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

    if (userData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please login to submit feedback"),
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

    // Submit feedback using Cubit
    context.read<FeedbackCubit>().addFeedbackAndRating(
      carId: feedbackModel.carId,
      userName: userData!.name as String,
      userId: userData!.uid as String,
      rating: rating.toDouble(),
      comment: feedback,
    );

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