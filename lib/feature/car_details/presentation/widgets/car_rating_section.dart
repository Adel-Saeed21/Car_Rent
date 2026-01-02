import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/core/widgets/app_button.dart';
import 'package:carrent/feature/feedback/domain/entities/feedback_entity.dart';
import 'package:carrent/feature/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:carrent/feature/feedback/presentation/cubit/feedback_state.dart';
import 'package:carrent/feature/feedback/presentation/widgets/edit_feedback_dialog.dart';
import 'package:carrent/feature/feedback/presentation/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarRatingSection extends StatelessWidget {
  final String carId;
  final String carName;
  final String userId;
  final String userName;

  const CarRatingSection({
    super.key,
    required this.carId,
    required this.carName,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackCubit, FeedbackState>(
      builder: (context, state) {
        if (state is CarFeedbackLoaded) {
          final feedback = state.feedback;
          final userFeedback = state.userFeedback;
          final totalReviews = feedback.totalReviews;
          final averageRating = feedback.averageRating;

          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.lightBlack,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.cyan.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reviews ($totalReviews)',
                      style: AppTextStyle.font20WhiteRgular.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: AppTextStyle.font20WhiteRgular.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(16.h),
                
                 
                if (userFeedback != null) ...[
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Review',
                              style: AppTextStyle.font20WhiteRgular.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.lightBlue,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, size: 18.sp, color: AppColors.offWhite),
                              onPressed: () => _showEditFeedbackDialog(context, userFeedback),
                            ),
                          ],
                        ),
                        StarRatingWidget(rating: userFeedback.rating, size: 16.sp),
                        verticalSpace(8.h),
                        Text(
                          userFeedback.comment,
                          style: AppTextStyle.font20WhiteRgular.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.offWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                    
                    
                    
                    
                    
                    
                    
                    
                   AppButton(
                      child: const Text('Rate this car'),
                     onPressed: () => _showAddFeedbackDialog(context),
                   ),
                ],

                 
                if (feedback.feedbacks.isNotEmpty) ...[
                   verticalSpace(16.h),
                   Text(
                     'Recent Reviews',
                     style: AppTextStyle.font20WhiteRgular.copyWith(
                       fontSize: 14.sp,
                       fontWeight: FontWeight.bold,
                       color: AppColors.offWhite,
                     ),
                   ),
                   verticalSpace(8.h),
                   ...feedback.feedbacks.take(3).map((f) {
                     if (f.userId == userId) return const SizedBox.shrink();  
                     return Padding(
                       padding: EdgeInsets.only(bottom: 12.h),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 f.userName,
                                 style: AppTextStyle.font20WhiteRgular.copyWith(
                                   fontSize: 12.sp,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                               Text(
                                 f.formattedDate,
                                 style: AppTextStyle.font20WhiteRgular.copyWith(
                                   fontSize: 10.sp,
                                   color: AppColors.offWhite.withOpacity(0.5),
                                 ),
                               ),
                             ],
                           ),
                           StarRatingWidget(rating: f.rating, size: 12.sp),
                           verticalSpace(4.h),
                           Text(
                             f.comment,
                             style: AppTextStyle.font20WhiteRgular.copyWith(
                               fontSize: 12.sp,
                               color: AppColors.offWhite.withOpacity(0.7),
                             ),
                           ),
                         ],
                       ),
                     );
                   }),
                ],
              ],
            ),
          );
        }
        
         
        return Container(
             padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.lightBlack,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.cyan.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'No reviews yet',
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.offWhite,
                  ),
                ),
                verticalSpace(12.h),
                 AppButton(
                     child:const Text('Be the first to rate'),
                     onPressed: () => _showAddFeedbackDialog(context),
                   ),
              ],
            ),
        );
      },
    );
  }

  void _showAddFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => EditFeedbackDialog(
        carName: carName,
        onSave: (rating, comment) {
          context.read<FeedbackCubit>().addFeedback(
            carId: carId,
            userId: userId,
            userName: userName,
            rating: rating,
            comment: comment,
          );
        },
      ),
    );
  }

  void _showEditFeedbackDialog(BuildContext context, FeedbackItemEntity existingFeedback) {
    showDialog(
      context: context,
      builder: (_) => EditFeedbackDialog(
        carName: carName,
        initialRating: existingFeedback.rating,
        initialComment: existingFeedback.comment,
        isEditing: true,
        onSave: (rating, comment) {
          context.read<FeedbackCubit>().updateFeedback(
            carId: carId,
            userId: userId,
            rating: rating,
            comment: comment,
          );
        },
      ),
    );
  }
}
