import 'package:carrent/feature/Booking/data/repo/i_booking_repo.dart';
import 'package:carrent/feature/FeedBack/data/Repos/i_feedback_repo.dart';
import 'package:carrent/feature/car_Details/logic/car_details_state.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
  CarDetailsCubit(this.dailyPrice, this.bookingRepository, this.feedbackRepository, this.carModel) 
      : super(const CarDetailsState());

  final double dailyPrice;
  final CarModel carModel;
  final IBookingRepository bookingRepository;
  final IFeedbackRepository feedbackRepository;

  void selectStartDate(DateTime date) {
    DateTime? newEndDate = state.endDate;
    if (newEndDate != null && newEndDate.isBefore(date)) {
      newEndDate = null;
    }
    emit(state.copyWith(startDate: date, endDate: newEndDate));
  }

  void selectEndDate(DateTime date) {
    emit(state.copyWith(endDate: date));
  }

  int? getRentalDays() {
    if (state.startDate != null && state.endDate != null) {
      return state.endDate!.difference(state.startDate!).inDays + 1;
    }
    return null;
  }

  double getCarPrice() {
    if (state.startDate != null && state.endDate != null) {
      return dailyPrice * (state.endDate!.difference(state.startDate!).inDays + 1);
    } else {
      return 0;
    }
  }

  Future<void> bookCar(String userId) async {
  if (state.startDate == null || state.endDate == null) return;

  try {
    emit(state.copyWith(isLoading: true, error: null));
    
    print("Starting booking process..."); 

    print("Checking car availability...");
    bool canBook = false;
    try {
      canBook = bookingRepository.canBookCar(carModel.id, state.startDate!, state.endDate!);
    } catch (e) {
      print("Error in canBookCar: $e");
      throw Exception("Failed to check car availability: $e");
    }
    
    if (!canBook) {
      emit(state.copyWith(
        error: "Car is not available for selected dates",
        isLoading: false
      ));
      return;
    }

    print("Creating booking...");
    String bookingId = "";
    try {
      bookingId = await bookingRepository.createBooking(
        carModel.id,
        userId,
        state.startDate!,
        state.endDate!
      );
    } catch (e) {
      print("Error in createBooking: $e");
      throw Exception("Failed to create booking: $e");
    }

    print("Checking existing feedback...");
    try {
      final existingFeedback = feedbackRepository.getCarFeedback(carModel.id);
      
      if (existingFeedback == null) {
        print("Adding car to feedback list...");
        await feedbackRepository.addBookedCar(carModel,bookingId);
      } else {
        print("Car already exists in feedback list");
      }
    } catch (e) {
      print("Error in feedback operations: $e");
      print("Continuing despite feedback error...");
    }

    emit(state.copyWith(
      bookingSuccess: true,
      isLoading: false,
      error: null
    ));

  } catch (e) {
    print("General booking error: $e");
    emit(state.copyWith(
      error: "Booking failed: $e",
      isLoading: false
    ));
  }
}
}