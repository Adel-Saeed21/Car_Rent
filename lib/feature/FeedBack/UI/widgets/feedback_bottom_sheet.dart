import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/FeedBack/Logic/feedback_cubit.dart';
import 'package:carrent/feature/FeedBack/UI/widgets/star_rating_widget.dart';
import 'package:carrent/feature/FeedBack/data/feedback_model.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

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