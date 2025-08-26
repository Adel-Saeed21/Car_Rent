import 'package:carrent/feature/FeedBack/Logic/feedback_state.dart';
import 'package:carrent/feature/FeedBack/data/Repos/i_feedback_repo.dart';
import 'package:carrent/feature/FeedBack/data/feedback_model.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final IFeedbackRepository feedbackRepository;

  FeedbackCubit(this.feedbackRepository) : super(FeedbackInitial());

  void loadBookedCars() {
    try {
      emit(FeedbackLoading());
      final bookedCars = feedbackRepository.getBookedCars();
      emit(BookedCarsLoaded(bookedCars));
    } catch (e) {
      emit(FeedbackError("Failed to load booked cars: $e"));
    }
  }

  // إضافة عربية جديدة للقائمة المحجوزة
  Future<void> addBookedCar(CarModel car) async {
    try {
      await feedbackRepository.addBookedCar(car);
      loadBookedCars(); // إعادة تحميل القائمة
    } catch (e) {
      emit(FeedbackError("Failed to add booked car: $e"));
    }
  }

  Future<void> addFeedbackAndRating({
    required String carId,
    required String userName,
    required String userId,
    required double rating,
    required String comment,
  }) async {
    try {
      emit(FeedbackLoading());
      
      final feedbackItem = FeedbackItem(
        userName: userName,
        rating: rating,
        comment: comment,
        createdAt: DateTime.now(),
        userId: userId,
      );

      await feedbackRepository.addFeedback(carId, feedbackItem);
      
      emit(FeedbackAddedSuccessfully("Thank you for your feedback!"));
      
      loadBookedCars();
    } catch (e) {
      emit(FeedbackError("Failed to add feedback: $e"));
    }
  }

  // Future<void> removeBookedCar(String carId) async {
  //   try {
  //     await feedbackRepository.removeBookedCar(carId);
  //     loadBookedCars();
  //   } catch (e) {
  //     emit(FeedbackError("Failed to remove car: $e"));
  //   }
  // }

  // FeedbackModel? getCarFeedback(String carId) {
  //   return feedbackRepository.getCarFeedback(carId);
  // }
}