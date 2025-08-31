// ignore_for_file: use_build_context_synchronously

import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/Booking/data/repo/i_booking_repo.dart';
import 'package:carrent/feature/FeedBack/data/Repos/i_feedback_repo.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:carrent/feature/car_Details/logic/car_details_state.dart';
import 'package:carrent/feature/car_Details/logic/car_detials_cubit.dart';
import 'package:carrent/feature/car_Details/widgets/specification_car_widget.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class CarDetailsWidget extends StatefulWidget {
  final List<SpecificationData> specifications;
  final List<String> features;
  final double price;
  final IBookingRepository bookingRepository;
  final IFeedbackRepository feedbackRepository;
  final CarModel carModel;

  const CarDetailsWidget({
    super.key,
    required this.specifications,
    required this.features,
    required this.price,
    required this.bookingRepository,
    required this.feedbackRepository,
    required this.carModel,
  });

  @override
  State<CarDetailsWidget> createState() => _CarDetailsWidgetState();
}

class _CarDetailsWidgetState extends State<CarDetailsWidget> {
  UserData? userData;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    var box = await Hive.openBox<UserData>('UserDataBox');
    setState(() {
      userData = box.get('currentUser');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CarDetailsCubit(
          widget.price,
          widget.bookingRepository,
          widget.feedbackRepository,
          widget.carModel,
        );
        
        _initializeRepositories(cubit);
        
        return cubit;
      },
      child: Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkGrey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Title and Description
                Text(
                  "Tesla Model",
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    fontWeight: FontWeightHelper.bold,
                    fontSize: 25,
                  ),
                ),
                verticalSpace(8.h),
                Text(
                  "This car made by Tesla and it more comfortable",
                  style: AppTextStyle.font20WhiteRgular.copyWith(
                    color: AppColors.offWhite,
                    fontSize: 14,
                  ),
                ),
                verticalSpace(20.h),
                SpecificationGrid(
                  specifications: widget.specifications,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                ),
                verticalSpace(20.h),
                _buildAdditionalFeatures(),
                verticalSpace(20.h),
                _buildTimeBook(),
                verticalSpace(10.h),
                _buildRentButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _initializeRepositories(CarDetailsCubit cubit) async {
    try {
      await widget.bookingRepository.init();
      await widget.feedbackRepository.init();
    } catch (error) {
      print('Error initializing repositories: $error');
    }
  }

  // باقي الدوال تبقى كما هي...
  Widget _buildAdditionalFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Features",
          style: AppTextStyle.font20WhiteRgular.copyWith(
            fontWeight: FontWeightHelper.bold,
            fontSize: 18,
          ),
        ),
        verticalSpace(12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: widget.features.map((feature) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.lightBlack,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.cyan.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                feature,
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.offWhite,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRentButton(BuildContext context) {
    return BlocListener<CarDetailsCubit, CarDetailsState>(
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
        }
      },
      child: BlocBuilder<CarDetailsCubit, CarDetailsState>(
        builder: (context, state) {
          final cubit = context.read<CarDetailsCubit>();
          final totalPrice = cubit.getCarPrice();
          final hasSelectedDates = state.startDate != null && state.endDate != null;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: hasSelectedDates && !state.isLoading
                  ? () {
                      String? userId = userData!.uid;
                      cubit.bookCar(userId!);
                    }
                  : null,
              child: Center(
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.car_rental,
                            color: hasSelectedDates ? Colors.white : Colors.grey.shade400,
                            size: 20.sp,
                          ),
                          horizontalSpace(8.w),
                          Text(
                            hasSelectedDates
                                ? "Rent Now - \$${totalPrice.toStringAsFixed(2)}"
                                : "Select dates to rent",
                            style: AppTextStyle.font20WhiteRgular.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeightHelper.bold,
                              color: hasSelectedDates ? Colors.white : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeBook() {
    return BlocBuilder<CarDetailsCubit, CarDetailsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rental Period",
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontWeight: FontWeightHelper.bold,
                fontSize: 18,
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
            if (state.startDate != null && state.endDate != null) ...[
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
                      "${context.read<CarDetailsCubit>().getRentalDays()} days",
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
      context.read<CarDetailsCubit>().selectEndDate(picked);
    }
  }
}