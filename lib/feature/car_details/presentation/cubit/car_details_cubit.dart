import 'package:bloc/bloc.dart';
import 'package:carrent/feature/booking/domain/entities/booking_entity.dart';
import 'package:carrent/feature/booking/domain/repositories/i_booking_repository.dart';
import 'package:carrent/feature/car_details/presentation/cubit/car_details_state.dart';
import 'package:flutter/material.dart';

 
class CarDetailsCubit extends Cubit<CarDetailsState> {
  final IBookingRepository _bookingRepository;
  final double pricePerDay;
  final String carId;

  CarDetailsCubit({
    required IBookingRepository bookingRepository,
    required this.pricePerDay,
    required this.carId,
  }) : _bookingRepository = bookingRepository,
       super(const CarDetailsState());

  void selectStartAndEndDates(DateTimeRange range) {
    emit(state.copyWith(
      startDate: range.start,
      endDate: range.end,
    ));
  }

  void selectStartDate(DateTime date) {
     
    if (state.endDate != null && state.endDate!.isBefore(date)) {
      emit(state.copyWith(startDate: date, endDate: null));
    } else {
      emit(state.copyWith(startDate: date));
    }
  }

  void selectEndDate(DateTime date) {
    if (state.startDate == null) return;
    if (date.isBefore(state.startDate!)) return;  
    
    emit(state.copyWith(endDate: date));
  }

  double get totalPrice {
    if (state.startDate == null || state.endDate == null) return 0.0;
    
    final days = state.endDate!.difference(state.startDate!).inDays + 1;
    return days * pricePerDay;
  }
  
  int get rentalDays {
    if (state.startDate == null || state.endDate == null) return 0;
    return state.endDate!.difference(state.startDate!).inDays + 1;
  }

  Future<void> bookCar(String userId) async {
    if (state.startDate == null || state.endDate == null) {
      emit(state.copyWith(error: "Please select rental dates"));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, clearError: true));

      final booking = BookingEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        carId: carId,
        userId: userId,
        startDate: state.startDate!,
        endDate: state.endDate!,
        bookingTime: DateTime.now(),
        status: BookingStatus.active,
      );

      await _bookingRepository.createBooking(booking);

      emit(state.copyWith(
        isLoading: false,
        bookingSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "Failed to book car: ${e.toString()}",
      ));
    }
  }
}
