import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/FeedBack/Logic/feedback_cubit.dart';
import 'package:carrent/feature/FeedBack/UI/widgets/feedback_bottom_sheet.dart';
import 'package:carrent/feature/FeedBack/UI/widgets/star_rating_widget.dart';
import 'package:carrent/feature/FeedBack/data/feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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