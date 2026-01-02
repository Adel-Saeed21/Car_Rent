import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/functions/is_user_login.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:carrent/feature/feedback/presentation/cubit/feedback_state.dart';
import 'package:carrent/feature/feedback/presentation/widgets/edit_feedback_dialog.dart';
import 'package:carrent/feature/feedback/presentation/widgets/star_rating_widget.dart';
import 'package:carrent/feature/car/presentation/widgets/car_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<FeedbackCubit>()..loadBookedCars(getUserId()),
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        appBar: AppBar(
          backgroundColor: AppColors.darkBlack,
          elevation: 0,
          title: Text(
            'My Feedback',
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            if (state is FeedbackOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.lightBlue,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
            if (state is FeedbackError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is FeedbackLoading) {
              return  Center(
                child: CircularProgressIndicator(
                  color: AppColors.lightBlue,
                ),
              );
            }

            if (state is FeedbackEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.messageDraw,
                      size: 100.sp,
                       
                      color: AppColors.lightBlue.withOpacity(0.3),
                    ),
                    verticalSpace(20.h),
                    Text(
                      'No Cars to Review',
                      style: AppTextStyle.font20WhiteRgular.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Text(
                        'Complete a booking to leave feedback and rate your experience.',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.font20WhiteRgular.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.offWhite.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is FeedbackLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<FeedbackCubit>().loadBookedCars(getUserId());
                },
                color: AppColors.lightBlue,
                backgroundColor: AppColors.darkGrey,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  itemCount: state.bookedCars.length,
                  itemBuilder: (context, index) {
                    final car = state.bookedCars[index];
                    final userFeedback = state.userFeedbacks[car.id];
                    final hasFeedback = userFeedback != null;

                    return Column(
                      children: [
                        CarCardWidget(
                          car: car,
                          isFavorite: false,  
                        ),
                        verticalSpace(10.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.darkGrey,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: hasFeedback
                                  ? AppColors.lightBlue.withOpacity(0.5)
                                  : Colors.transparent,
                            ),
                          ),
                          child: hasFeedback
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Your Review',
                                          style: AppTextStyle.font20WhiteRgular
                                              .copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.lightBlue,
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColors.offWhite,
                                            size: 20.sp,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => EditFeedbackDialog(
                                                carName: car.name,
                                                initialRating: userFeedback.rating,
                                                initialComment: userFeedback.comment,
                                                isEditing: true,
                                                onSave: (rating, comment) {
                                                  context
                                                      .read<FeedbackCubit>()
                                                      .updateFeedback(
                                                        carId: car.id,
                                                        userId: getUserId(),
                                                        rating: rating,
                                                        comment: comment,
                                                      );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    verticalSpace(8.h),
                                    StarRatingWidget(
                                      rating: userFeedback.rating,
                                      size: 16.sp,
                                    ),
                                    verticalSpace(8.h),
                                    Text(
                                      userFeedback.comment,
                                      style: AppTextStyle.font20WhiteRgular
                                          .copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.offWhite,
                                      ),
                                    ),
                                    verticalSpace(4.h),
                                    Text(
                                      userFeedback.formattedDate,
                                      style: AppTextStyle.font20WhiteRgular
                                          .copyWith(
                                        fontSize: 12.sp,
                                        color: AppColors.offWhite
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text(
                                      'How was your trip?',
                                      style: AppTextStyle.font20WhiteRgular
                                          .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    verticalSpace(10.h),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.lightBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => EditFeedbackDialog(
                                            carName: car.name,
                                            onSave: (rating, comment) {
                                              context
                                                  .read<FeedbackCubit>()
                                                  .addFeedback(
                                                    carId: car.id,
                                                    userId: getUserId(),
                                                    userName: getUserName(),
                                                    rating: rating,
                                                    comment: comment,
                                                  );
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text('Leave Feedback'),
                                    ),
                                  ],
                                ),
                        ),
                        verticalSpace(30.h),
                      ],
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

   
  String getUserId() {
    return getUserEmail() ?? 'default_user';
  }

   
  String getUserName() {
    return 'John Doe';  
  }
}
