import 'package:carrent/feature/FeedBack/data/Repos/i_feedback_repo.dart';
import 'package:carrent/feature/FeedBack/data/feedback_model.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:hive/hive.dart';

class FeedbackRepository extends IFeedbackRepository {
  static const String feedbackBoxName = 'feedbackBox';
  late Box<FeedbackModel> feedbackBox;

  @override
  Future<void> init() async {
    feedbackBox = await Hive.openBox<FeedbackModel>(feedbackBoxName);
  }

  @override
  List<FeedbackModel> getBookedCars() {
    return feedbackBox.values.toList();
  }

  @override
  FeedbackModel? getCarFeedback(String carId) {
    return feedbackBox.values
        .where((feedback) => feedback.carId == carId)
        .firstOrNull;
  }

  @override
  Future<void> addBookedCar(CarModel car) async {
    final existingFeedback = getCarFeedback(car.id);
    if (existingFeedback == null) {
      final feedbackModel = FeedbackModel.fromCarModel(car);
      await feedbackBox.put(car.id, feedbackModel);
    }
  }

  @override
  Future<void> addFeedback(String carId, FeedbackItem feedback) async {
    final existingFeedback = getCarFeedback(carId);
    if (existingFeedback != null) {
      final updatedFeedback = existingFeedback.addFeedback(feedback);
      await feedbackBox.put(carId, updatedFeedback);
    }
  }

  @override
  Future<void> removeBookedCar(String carId) async {
    await feedbackBox.delete(carId);
  }

  @override
  Future<void> clearAll() async {
    await feedbackBox.clear();
  }
  @override
  bool isCarBooked(String carId) {
    return feedbackBox.containsKey(carId);
  }

  @override
  void dispose() {
    feedbackBox.close();
  }
}
