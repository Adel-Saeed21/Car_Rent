import 'package:bloc/bloc.dart';
import 'package:carrent/feature/feedback/domain/entities/feedback_entity.dart';
import 'package:carrent/feature/feedback/domain/usecases/add_feedback_usecase.dart';
import 'package:carrent/feature/feedback/domain/usecases/get_booked_cars_usecase.dart';
import 'package:carrent/feature/feedback/domain/usecases/get_car_feedbacks_usecase.dart';
import 'package:carrent/feature/feedback/domain/usecases/update_feedback_usecase.dart';
import 'package:carrent/feature/feedback/presentation/cubit/feedback_state.dart';

 
class FeedbackCubit extends Cubit<FeedbackState> {
  final GetBookedCarsUseCase _getBookedCarsUseCase;
  final GetCarFeedbacksUseCase _getCarFeedbacksUseCase;
  final AddFeedbackUseCase _addFeedbackUseCase;
  final UpdateFeedbackUseCase _updateFeedbackUseCase;

  FeedbackCubit(
    this._getBookedCarsUseCase,
    this._getCarFeedbacksUseCase,
    this._addFeedbackUseCase,
    this._updateFeedbackUseCase,
  ) : super(FeedbackInitial());

   
  Future<void> loadBookedCars(String userId) async {
    try {
      emit(FeedbackLoading());
      final bookedCars = await _getBookedCarsUseCase(userId);
      
      if (bookedCars.isEmpty) {
        emit(FeedbackEmpty());
        return;
      }

       
      final Map<String, FeedbackItemEntity> userFeedbacks = {};
      
      for (final car in bookedCars) {
        final feedbackEntity = await _getCarFeedbacksUseCase(car.id);
        if (feedbackEntity != null) {
          final userFeedback = feedbackEntity.getUserFeedback(userId);
          if (userFeedback != null) {
            userFeedbacks[car.id] = userFeedback;
          }
        }
      }

      emit(FeedbackLoaded(
        bookedCars: bookedCars,
        userFeedbacks: userFeedbacks,
      ));
    } catch (e) {
      emit(FeedbackError('Failed to load booked cars: ${e.toString()}'));
    }
  }

   
  Future<void> loadCarFeedback(String carId, String userId) async {
    try {
      emit(FeedbackLoading());
      final feedbackEntity = await _getCarFeedbacksUseCase(carId);
      
      if (feedbackEntity != null) {
        emit(CarFeedbackLoaded(
          feedbackEntity,
          feedbackEntity.getUserFeedback(userId),
        ));
      } else {
         
         
         emit(FeedbackEmpty());
      }
    } catch (e) {
      emit(FeedbackError('Failed to load car feedback: ${e.toString()}'));
    }
  }

   
  Future<void> addFeedback({
    required String carId,
    required String userId,
    required String userName,
    required double rating,
    required String comment,
    String? bookingId,
  }) async {
    try {
      final params = AddFeedbackParams(
        carId: carId,
        userId: userId,
        userName: userName,
        rating: rating,
        comment: comment,
        bookingId: bookingId,
      );
      
      await _addFeedbackUseCase(params);
      emit(FeedbackOperationSuccess('Feedback added successfully'));
      
       
      await loadBookedCars(userId);
    } catch (e) {
      emit(FeedbackError('Failed to add feedback: ${e.toString()}'));
    }
  }

   
  Future<void> updateFeedback({
    required String carId,
    required String userId,
    required double rating,
    required String comment,
  }) async {
    try {
      final params = UpdateFeedbackParams(
        carId: carId,
        userId: userId,
        rating: rating,
        comment: comment,
      );
      
      await _updateFeedbackUseCase(params);
      emit(FeedbackOperationSuccess('Feedback updated successfully'));
      
       
      await loadBookedCars(userId);
    } catch (e) {
      emit(FeedbackError('Failed to update feedback: ${e.toString()}'));
    }
  }
}
