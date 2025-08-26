import 'package:carrent/feature/FeedBack/data/feedback_model.dart';

abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class BookedCarsLoaded extends FeedbackState {
  final List<FeedbackModel> bookedCars;
  BookedCarsLoaded(this.bookedCars);
}

class FeedbackAddedSuccessfully extends FeedbackState {
  final String message;
  FeedbackAddedSuccessfully(this.message);
}

class FeedbackError extends FeedbackState {
  final String error;
  FeedbackError(this.error);
}
