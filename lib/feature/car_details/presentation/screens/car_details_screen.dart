import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/functions/is_user_login.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/car_details/presentation/cubit/car_details_cubit.dart';
import 'package:carrent/feature/car_details/presentation/cubit/car_details_state.dart';
import 'package:carrent/feature/car/data/models/car_model.dart';
import 'package:carrent/feature/car_details/presentation/widgets/car_details_app_bar.dart';
import 'package:carrent/feature/car_details/presentation/widgets/car_rating_section.dart';
import 'package:carrent/feature/car_details/presentation/widgets/car_showcase_widget.dart';
import 'package:carrent/feature/car_details/presentation/widgets/specification_car_widget.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:carrent/feature/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarEntity car;

  const CarDetailsScreen({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
     
    final userId = getUserEmail() ?? 'default_user';
    const userName = 'User';  

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getit<CarDetailsCubit>(
            param1: car.pricePerDay,
            param2: car.id,  
          ),
        ),
        BlocProvider.value(
          value: getit<FavoriteCubit>()..isFavorite(userId, car.id),
        ),
        BlocProvider(
          create: (context) => getit<FeedbackCubit>()..loadCarFeedback(car.id, userId),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.lightBlack,
        body: Column(
          children: [
            CarDetailsAppBar(car: car, userId: userId),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     
                    SizedBox(
                      height: 250.h,
                      width: double.infinity,
                      child: Center(
                        child: CarShowcaseWidget(
                          carImageUrl: car.imageAsset,
                          width: 350.w,
                          height: 250.h,
                          glowColor: Colors.cyan,
                        ),
                      ),
                    ),
                    
                     
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car.name,
                            style: AppTextStyle.font20WhiteRgular.copyWith(
                              fontWeight: FontWeightHelper.bold,
                              fontSize: 25.sp,
                            ),
                          ),
                          verticalSpace(8.h),
                          Text(
                            "${car.brand} - A premium driving experience.",
                            style: AppTextStyle.font20WhiteRgular.copyWith(
                              color: AppColors.offWhite,
                              fontSize: 14.sp,
                            ),
                          ),

                          verticalSpace(20.h),

                           
                          if (car.carDataSpecification != null && car.carDataSpecification!.isNotEmpty)
                             SpecificationGrid(
                               specifications: car.carDataSpecification!
                                  .map((e) => SpecificationDataModel.fromEntity(e))
                                  .toList(),
                               crossAxisCount: 2,
                               mainAxisSpacing: 12.h,
                               crossAxisSpacing: 12.w,
                             ),

                          verticalSpace(20.h),
                          
                           
                          CarRatingSection(
                            carId: car.id,
                            carName: car.name,
                            userId: userId,
                            userName: userName,
                          ),

                          verticalSpace(20.h),

                           
                          _BookingSection(car: car, userId: userId),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingSection extends StatelessWidget {
  final CarEntity car;
  final String userId;

  const _BookingSection({
    required this.car,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarDetailsCubit, CarDetailsState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state.bookingSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Car booked successfully!'),
              backgroundColor: Colors.green,
            ),
          );
           
           Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CarDetailsCubit>();
        final hasSelectedDates = state.startDate != null && state.endDate != null;
        final totalPrice = cubit.totalPrice;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rental Period",
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontWeight: FontWeightHelper.bold,
                fontSize: 18.sp,
              ),
            ),
            verticalSpace(12.h),
            Row(
              children: [
                Expanded(
                  child: _buildDateSelector(
                    context,
                    label: "Start Date",
                    selectedDate: state.startDate,
                    onTap: () => _selectStartDate(context),
                  ),
                ),
                horizontalSpace(12.w),
                Expanded(
                  child: _buildDateSelector(
                    context,
                    label: "End Date",
                    selectedDate: state.endDate,
                    onTap: () => _selectEndDate(context),
                  ),
                ),
              ],
            ),
            
            if (hasSelectedDates) ...[
               verticalSpace(12.h),
               Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: Colors.cyan.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rental Days:",
                      style: AppTextStyle.font20WhiteRgular.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.offWhite,
                      ),
                    ),
                    Text(
                      "${cubit.rentalDays} days",
                      style: AppTextStyle.font20WhiteRgular.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.bold,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            verticalSpace(20.h),

             
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton.icon(
                onPressed: hasSelectedDates && !state.isLoading
                    ? () => cubit.bookCar(userId)
                    : null,
                icon: state.isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(Icons.car_rental, size: 20.sp),
                label: Text(
                  hasSelectedDates
                      ? "Rent Now - \$${totalPrice.toStringAsFixed(2)}"
                      : "Select dates to rent",
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeightHelper.bold,
                    color: hasSelectedDates ? Colors.white : AppColors.offWhite,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasSelectedDates
                      ? AppColors.lightBlue
                      : AppColors.lightBlack,
                  foregroundColor: hasSelectedDates
                      ? Colors.white
                      : AppColors.offWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                   side: hasSelectedDates 
                  ? null 
                  : BorderSide(
                      color: Colors.cyan.withOpacity(0.3),
                      width: 1,
                    ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateSelector(
    BuildContext context, {
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.font20WhiteRgular.copyWith(fontSize: 14.sp),
        ),
        verticalSpace(8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.lightBlack,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.cyan.withOpacity(0.3), width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.cyan, size: 16.sp),
                horizontalSpace(8.w),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
                        : "Select Date",
                    style: AppTextStyle.font20WhiteRgular.copyWith(
                      fontSize: 14.sp,
                      color: selectedDate != null
                          ? Colors.white
                          : AppColors.offWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.lightBlue,
              onPrimary: AppColors.offWhite,
              surface: AppColors.lightBlack,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // ignore: use_build_context_synchronously
      context.read<CarDetailsCubit>().selectStartDate(picked);
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final state = context.read<CarDetailsCubit>().state;
    if (state.startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select start date first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.startDate!.add(const Duration(days: 1)),
      firstDate: state.startDate!.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.lightBlue,
              onPrimary: AppColors.lightBlack,
              surface: AppColors.lightBlack,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // ignore: use_build_context_synchronously
      context.read<CarDetailsCubit>().selectEndDate(picked);
    }
  }
}
