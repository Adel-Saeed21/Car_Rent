import 'package:carrent/feature/feedback/data/models/feedback_model.dart';
import 'package:hive/hive.dart';

 
class FeedbackLocalDataSource {
  static const String _boxName = 'feedbacks';

   
  Future<Box<FeedbackModel>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<FeedbackModel>(_boxName);
    }
    return Hive.box<FeedbackModel>(_boxName);
  }

   
  Future<void> saveFeedback(FeedbackModel feedback) async {
    final box = await _getBox();
    await box.put(feedback.carId, feedback);
  }

   
  Future<FeedbackModel?> getFeedbackByCarId(String carId) async {
    final box = await _getBox();
    return box.get(carId);
  }

   
  Future<List<FeedbackModel>> getAllFeedbacks() async {
    final box = await _getBox();
    return box.values.toList();
  }

   
  Future<void> deleteFeedback(String carId) async {
    final box = await _getBox();
    await box.delete(carId);
  }

   
  Future<bool> hasFeedback(String carId) async {
    final box = await _getBox();
    return box.containsKey(carId);
  }
}
