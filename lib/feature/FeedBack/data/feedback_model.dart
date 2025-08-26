import 'package:carrent/feature/home/data/car_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class FeedbackModel {
  @HiveField(0)
  final String carId; // للربط مع CarModel
  
  @HiveField(1)
  final String carName;
  
  @HiveField(2)
  final String carBrand;
  
  @HiveField(3)
  final String carImage;
  
  @HiveField(4)
  final List<FeedbackItem> feedbacks;

  FeedbackModel({
    required this.carId,
    required this.carName,
    required this.carBrand,
    required this.carImage,
    required this.feedbacks,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);

  factory FeedbackModel.fromCarModel(CarModel car) {
    return FeedbackModel(
      carId: car.id,
      carName: car.name,
      carBrand: car.brand,
      carImage: car.imageAsset,
      feedbacks: [],
    );
  }

  FeedbackModel addFeedback(FeedbackItem feedback) {
    return FeedbackModel(
      carId: carId,
      carName: carName,
      carBrand: carBrand,
      carImage: carImage,
      feedbacks: [...feedbacks, feedback],
    );
  }

  double get averageRating {
    if (feedbacks.isEmpty) return 0.0;
    final totalRating = feedbacks.fold<double>(
      0.0,
      (sum, feedback) => sum + feedback.rating,
    );
    return totalRating / feedbacks.length;
  }

  int get totalReviews => feedbacks.length;
}
@HiveType(typeId: 3)
@JsonSerializable()
class FeedbackItem {
  @HiveField(0)
  final String userName;
  
  @HiveField(1)
  final double rating;
  
  @HiveField(2)
  final String comment;
  
  @HiveField(3)
  final DateTime createdAt;
  
  @HiveField(4)
  final String userId; 

  FeedbackItem({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.userId,
  });

  factory FeedbackItem.fromJson(Map<String, dynamic> json) =>
      _$FeedbackItemFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackItemToJson(this);

  // Format the date for display
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else {
      return "${(difference.inDays / 30).floor()} months ago";
    }
  }
}
