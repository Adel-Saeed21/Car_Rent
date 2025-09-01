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
import 'package:carrent/core/di/di.dart';
class StarRatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  final bool isInteractive;
  final Function(int)? onRatingChanged;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.size = 20,
    this.color = Colors.amber,
    this.isInteractive = false,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData iconData;
        if (index < rating.floor()) {
          iconData = Icons.star;
        } else if (index < rating) {
          iconData = Icons.star_half;
        } else {
          iconData = Icons.star_border;
        }

        Widget star = Icon(
          iconData,
          color: color,
          size: size,
        );

        if (isInteractive) {
          return GestureDetector(
            onTap: () => onRatingChanged?.call(index + 1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: star,
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: star,
        );
      }),
    );
  }
}

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedbackCubit>(
      create: (context) => getit<FeedbackCubit>()..loadBookedCars(),
      child: const FeedbackView(),
    );
  }
}

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlack,
        elevation: 0,
        title: Text(
          "Feedback",
          style: AppTextStyle.font20WhiteRgular.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<FeedbackCubit, FeedbackState>(
            builder: (context, state) {
              return switch (state) {
                FeedbackInitial() => const _LoadingWidget(),
                FeedbackLoading() => const _LoadingWidget(),
                FeedbackError() => _ErrorWidget(
                    error: state.error,
                    onRetry: () => context.read<FeedbackCubit>().loadBookedCars(),
                  ),
                BookedCarsLoaded() => state.bookedCars.isEmpty
                    ? const _EmptyStateWidget()
                    : _BookedCarsListWidget(bookedCars: state.bookedCars),
                // TODO: Handle this case.
                FeedbackState() => throw UnimplementedError(),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorWidget({
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 64.sp,
          ),
          verticalSpace(20.h),
          Text(
            "Oops! Something went wrong",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpace(8.h),
          Text(
            error,
            style: AppTextStyle.font20WhiteRgular.copyWith(
              color: Colors.red.withOpacity(0.8),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpace(24.h),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text(
              "Try Again",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightBlue,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.darkGrey.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.car_rental_outlined,
              color: AppColors.lightBlue,
              size: 64.sp,
            ),
          ),
          verticalSpace(24.h),
          Text(
            "No Booked Cars Yet",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(8.h),
          Text(
            "Book a car to share your experience\nand help other customers!",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              color: AppColors.offWhite.withOpacity(0.7),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BookedCarsListWidget extends StatelessWidget {
  final List<FeedbackModel> bookedCars;

  const _BookedCarsListWidget({required this.bookedCars});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: bookedCars.length,
      separatorBuilder: (context, index) => verticalSpace(16.h),
      itemBuilder: (context, index) {
        return FeedbackCarCard(
          feedbackModel: bookedCars[index],
        );
      },
    );
  }
}

class FeedbackCarCard extends StatelessWidget {
  final FeedbackModel feedbackModel;

  const FeedbackCarCard({
    super.key,
    required this.feedbackModel,
  });


  
  @override
  Widget build(BuildContext context) {
    final hasRatings = feedbackModel.feedbacks.isNotEmpty;
    final averageRating = hasRatings ? feedbackModel.averageRating : 0.0;
    final reviewCount = feedbackModel.totalReviews;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.lightBlue.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, hasRatings, averageRating),
          _buildCarImage(),
          _buildRatingSection(hasRatings, averageRating, reviewCount),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool hasRatings, double averageRating) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedbackModel.carName,
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
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
                      horizontalSpace(12.w),
                      StarRatingWidget(
                        rating: averageRating,
                        size: 16.sp,
                      ),
                      horizontalSpace(8.w),
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: AppTextStyle.font20WhiteRgular.copyWith(
                          fontSize: 14.sp,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          _buildFeedbackButton(context),
        ],
      ),
    );
  }

  Widget _buildFeedbackButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lightBlue,
            AppColors.lightBlue.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightBlue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => _showFeedbackBottomSheet(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.rate_review,
                  color: Colors.white,
                  size: 18.sp,
                ),
                horizontalSpace(8.w),
                Text(
                  "Review",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarImage() {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            AppColors.lightBlue.withOpacity(0.1),
            Colors.transparent,
          ],
          center: Alignment.center,
          radius: 1.2,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.asset(
          feedbackModel.carImage,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.darkGrey.withOpacity(0.3),
              child: Icon(
                Icons.car_rental,
                color: AppColors.offWhite.withOpacity(0.5),
                size: 48.sp,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRatingSection(bool hasRatings, double averageRating, int reviewCount) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: hasRatings 
              ? AppColors.lightBlack.withOpacity(0.5)
              : AppColors.darkGrey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: hasRatings 
                ? Colors.amber.withOpacity(0.3)
                : AppColors.offWhite.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: hasRatings 
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      StarRatingWidget(
                        rating: averageRating,
                        size: 20.sp,
                      ),
                      horizontalSpace(12.w),
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: AppTextStyle.font20WhiteRgular.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "$reviewCount review${reviewCount != 1 ? 's' : ''}",
                    style: AppTextStyle.font20WhiteRgular.copyWith(
                      color: AppColors.offWhite.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  "No ratings yet - Be the first to rate!",
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    color: AppColors.offWhite.withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                ),
              ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildStarRating(double rating, {required double size}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData iconData;
        if (index < rating.floor()) {
          iconData = Icons.star;
        } else if (index < rating) {
          iconData = Icons.star_half;
        } else {
          iconData = Icons.star_border;
        }
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Icon(
            iconData,
            color: Colors.amber,
            size: size,
          ),
        );
      }),
    );
  }

  void _showFeedbackBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (modalContext) => BlocProvider.value(
        value: context.read<FeedbackCubit>(),
        child: FeedbackBottomSheet(feedbackModel: feedbackModel),
      ),
    );
  }
}

class FeedbackBottomSheet extends StatefulWidget {
  final FeedbackModel feedbackModel;

  const FeedbackBottomSheet({
    super.key,
    required this.feedbackModel,
  });

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  final TextEditingController _feedbackController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _selectedRating = 0;
  bool _isSubmitting = false;
  UserData? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final box = await Hive.openBox<UserData>('UserDataBox');
      if (mounted) {
        setState(() {
          _userData = box.get('currentUser');
        });
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(),
          Expanded(child: _buildContent()),
          _buildSubmissionArea(),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.offWhite.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.feedbackModel.carName,
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(4.h),
                Text(
                  "Share your experience",
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.offWhite.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: AppColors.offWhite,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: widget.feedbackModel.feedbacks.isEmpty
          ? _buildEmptyFeedback()
          : _buildFeedbackList(),
    );
  }

  Widget _buildEmptyFeedback() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rate_review_outlined,
            color: AppColors.offWhite.withOpacity(0.4),
            size: 48.sp,
          ),
          verticalSpace(16.h),
          Text(
            "No reviews yet",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              color: AppColors.offWhite.withOpacity(0.7),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildFeedbackList() {
    return ListView.separated(
      itemCount: widget.feedbackModel.feedbacks.length,
      separatorBuilder: (context, index) => verticalSpace(12.h),
      itemBuilder: (context, index) {
        final feedback = widget.feedbackModel.feedbacks[index];
        return _buildReviewItem(feedback);
      },
    );
  }

  Widget _buildReviewItem(dynamic feedback) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
                feedback.userName ?? "Anonymous",
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                feedback.formattedDate ?? "",
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.offWhite.withOpacity(0.6),
                ),
              ),
            ],
          ),
          verticalSpace(8.h),
          StarRatingWidget(
            rating: feedback.rating?.toDouble() ?? 0,
            size: 16.sp,
          ),
          if (feedback.comment?.isNotEmpty == true) ...[
            verticalSpace(8.h),
            Text(
              feedback.comment!,
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 14.sp,
                color: AppColors.offWhite.withOpacity(0.8),
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubmissionArea() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        border: Border(
          top: BorderSide(
            color: AppColors.lightBlue.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildRatingSelector(),
          verticalSpace(16.h),
          _buildCommentField(),
          verticalSpace(16.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildRatingSelector() {
    return Row(
      children: [
        Text(
          "Rate your experience:",
          style: AppTextStyle.font20WhiteRgular.copyWith(
            fontSize: 14.sp,
            color: AppColors.offWhite,
          ),
        ),
        horizontalSpace(12.w),
        StarRatingWidget(
          rating: _selectedRating.toDouble(),
          size: 24.sp,
          isInteractive: true,
          onRatingChanged: (rating) {
            setState(() {
              _selectedRating = rating;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCommentField() {
    return TextField(
      controller: _feedbackController,
      focusNode: _focusNode,
      maxLines: 4,
      maxLength: 500,
      style: AppTextStyle.font20WhiteRgular.copyWith(
        fontSize: 14.sp,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: "Tell us about your experience with this car...",
        hintStyle: AppTextStyle.font20WhiteRgular.copyWith(
          fontSize: 14.sp,
          color: AppColors.offWhite.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.lightBlue.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.lightBlue.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.lightBlue,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.darkGrey.withOpacity(0.3),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        counterStyle: TextStyle(
          color: AppColors.offWhite.withOpacity(0.5),
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isSubmitting ? null : () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppColors.lightBlue.withOpacity(0.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
            child: Text(
              "Cancel",
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 14.sp,
                color: AppColors.offWhite,
              ),
            ),
          ),
        ),
        horizontalSpace(16.w),
        Expanded(
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : _submitFeedback,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightBlue,
              disabledBackgroundColor: AppColors.lightBlue.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              elevation: 4,
            ),
            child: _isSubmitting
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      horizontalSpace(8.w),
                      Text(
                        "Submit Review",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _submitFeedback() async {
    // Validation
    if (_selectedRating == 0) {
      _showErrorSnackBar("Please select a rating");
      return;
    }

    if (_feedbackController.text.trim().isEmpty) {
      _showErrorSnackBar("Please write your feedback");
      return;
    }

    if (_userData == null) {
      _showErrorSnackBar("Please login to submit feedback");
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await context.read<FeedbackCubit>().addFeedbackAndRating(
        carId: widget.feedbackModel.carId,
        userName: _userData!.name as String,
        userId: _userData!.uid as String,
        rating: _selectedRating.toDouble(),
        comment: _feedbackController.text.trim(),
      );

      if (mounted) {
        _showSuccessSnackBar("Thank you for your feedback!");
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar("Failed to submit feedback. Please try again.");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20.sp),
            horizontalSpace(8.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
            horizontalSpace(8.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.lightBlue,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}