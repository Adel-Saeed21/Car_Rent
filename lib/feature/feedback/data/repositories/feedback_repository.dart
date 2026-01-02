import 'package:carrent/feature/feedback/data/datasources/feedback_local_data_source.dart';
import 'package:carrent/feature/feedback/data/models/feedback_model.dart';
import 'package:carrent/feature/feedback/domain/entities/feedback_entity.dart';
import 'package:carrent/feature/feedback/domain/repositories/i_feedback_repository.dart';

 
class FeedbackRepository implements IFeedbackRepository {
  final FeedbackLocalDataSource _localDataSource;

  FeedbackRepository(this._localDataSource);

  @override
  Future<void> addFeedback({
    required String carId,
    required String userId,
    required String userName,
    required double rating,
    required String comment,
    String? bookingId,
  }) async {
     
    final existingFeedback = await _localDataSource.getFeedbackByCarId(carId);

    final newFeedbackItem = FeedbackItemModel(
      userName: userName,
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
      userId: userId,
    );

    if (existingFeedback != null) {
       
      final updatedFeedback = FeedbackModel(
        carId: existingFeedback.carId,
        carName: existingFeedback.carName,
        carBrand: existingFeedback.carBrand,
        carImage: existingFeedback.carImage,
        feedbacks: [...existingFeedback.feedbacks, newFeedbackItem],
        bookingId: bookingId ?? existingFeedback.bookingId,
      );
      await _localDataSource.saveFeedback(updatedFeedback);
    } else {
       
       
       
      final newFeedback = FeedbackModel(
        carId: carId,
        carName: '',  
        carBrand: '',
        carImage: '',
        feedbacks: [newFeedbackItem],
        bookingId: bookingId,
      );
      await _localDataSource.saveFeedback(newFeedback);
    }
  }

  @override
  Future<void> updateFeedback({
    required String carId,
    required String userId,
    required double rating,
    required String comment,
  }) async {
    final existingFeedback = await _localDataSource.getFeedbackByCarId(carId);
    
    if (existingFeedback == null) return;

     
    final updatedFeedbacks = existingFeedback.feedbacks.map((feedback) {
      if (feedback.userId == userId) {
        return FeedbackItemModel(
          userName: feedback.userName,
          rating: rating,
          comment: comment,
          createdAt: feedback.createdAt,
          userId: userId,
        );
      }
      return feedback;
    }).toList();

    final updatedFeedback = FeedbackModel(
      carId: existingFeedback.carId,
      carName: existingFeedback.carName,
      carBrand: existingFeedback.carBrand,
      carImage: existingFeedback.carImage,
      feedbacks: updatedFeedbacks,
      bookingId: existingFeedback.bookingId,
    );

    await _localDataSource.saveFeedback(updatedFeedback);
  }

  @override
  Future<FeedbackEntity?> getCarFeedback(String carId) async {
    final feedback = await _localDataSource.getFeedbackByCarId(carId);
    return feedback?.toEntity();
  }

  @override
  Future<List<FeedbackEntity>> getAllFeedbacks() async {
    final feedbacks = await _localDataSource.getAllFeedbacks();
    return feedbacks.map((f) => f.toEntity()).toList();
  }

  @override
  Future<bool> hasUserFeedback(String carId, String userId) async {
    final feedback = await _localDataSource.getFeedbackByCarId(carId);
    if (feedback == null) return false;
    
    return feedback.feedbacks.any((f) => f.userId == userId);
  }

  @override
  Future<FeedbackItemEntity?> getUserFeedback(String carId, String userId) async {
    final feedback = await _localDataSource.getFeedbackByCarId(carId);
    if (feedback == null) return null;

    try {
      final userFeedback = feedback.feedbacks.firstWhere(
        (f) => f.userId == userId,
      );
      return userFeedback.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteFeedback(String carId, String userId) async {
    final existingFeedback = await _localDataSource.getFeedbackByCarId(carId);
    if (existingFeedback == null) return;

    final updatedFeedbacks = existingFeedback.feedbacks
        .where((f) => f.userId != userId)
        .toList();

    if (updatedFeedbacks.isEmpty) {
       
      await _localDataSource.deleteFeedback(carId);
    } else {
       
      final updatedFeedback = FeedbackModel(
        carId: existingFeedback.carId,
        carName: existingFeedback.carName,
        carBrand: existingFeedback.carBrand,
        carImage: existingFeedback.carImage,
        feedbacks: updatedFeedbacks,
        bookingId: existingFeedback.bookingId,
      );
      await _localDataSource.saveFeedback(updatedFeedback);
    }
  }
}
