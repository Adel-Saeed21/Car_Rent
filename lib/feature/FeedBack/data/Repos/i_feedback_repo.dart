import 'package:carrent/feature/FeedBack/data/feedback_model.dart';
import 'package:carrent/feature/home/data/car_model.dart';

abstract class IFeedbackRepository {
  Future<void> init();

  List<FeedbackModel> getBookedCars();

  FeedbackModel? getCarFeedback(String carId);

  Future<void> addBookedCar(CarModel car);

  Future<void> addFeedback(String carId, FeedbackItem feedback);

  Future<void> removeBookedCar(String carId);

  Future<void> clearAll();
  bool isCarBooked(String carId);

  void dispose();
}