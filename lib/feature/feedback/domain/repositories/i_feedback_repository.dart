import 'package:carrent/feature/feedback/domain/entities/feedback_entity.dart';

 
abstract class IFeedbackRepository {
   
  Future<void> addFeedback({
    required String carId,
    required String userId,
    required String userName,
    required double rating,
    required String comment,
    String? bookingId,
  });

   
  Future<void> updateFeedback({
    required String carId,
    required String userId,
    required double rating,
    required String comment,
  });

   
  Future<FeedbackEntity?> getCarFeedback(String carId);

   
  Future<List<FeedbackEntity>> getAllFeedbacks();

   
  Future<bool> hasUserFeedback(String carId, String userId);

   
  Future<FeedbackItemEntity?> getUserFeedback(String carId, String userId);

   
  Future<void> deleteFeedback(String carId, String userId);
}
