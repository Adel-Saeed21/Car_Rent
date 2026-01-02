import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/feedback/domain/entities/feedback_entity.dart';
import 'package:equatable/equatable.dart';

 
abstract class FeedbackState extends Equatable {
  @override
  List<Object?> get props => [];
}

 
class FeedbackInitial extends FeedbackState {}

 
class FeedbackLoading extends FeedbackState {}

 
class FeedbackLoaded extends FeedbackState {
  final List<CarEntity> bookedCars;
   
  final Map<String, FeedbackItemEntity> userFeedbacks;

  FeedbackLoaded({
    required this.bookedCars,
    this.userFeedbacks = const {},
  });

  @override
  List<Object?> get props => [bookedCars, userFeedbacks];
}

 
class CarFeedbackLoaded extends FeedbackState {
  final FeedbackEntity feedback;
  final FeedbackItemEntity? userFeedback;

  CarFeedbackLoaded(this.feedback, this.userFeedback);

  @override
  List<Object?> get props => [feedback, userFeedback];
}

 
class FeedbackEmpty extends FeedbackState {}

 
class FeedbackError extends FeedbackState {
  final String message;

  FeedbackError(this.message);

  @override
  List<Object?> get props => [message];
}

 
class FeedbackOperationSuccess extends FeedbackState {
  final String message;

  FeedbackOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
