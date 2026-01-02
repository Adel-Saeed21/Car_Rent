import 'package:carrent/feature/feedback/domain/entities/feedback_entity.dart';
import 'package:hive/hive.dart';

part 'feedback_model.g.dart';

@HiveType(typeId: 2)
class FeedbackModel extends HiveObject {
  @HiveField(0)
  final String carId;

  @HiveField(1)
  final String carName;

  @HiveField(2)
  final String carBrand;

  @HiveField(3)
  final String carImage;

  @HiveField(4)
  final List<FeedbackItemModel> feedbacks;

  @HiveField(5)
  final String? bookingId;

  FeedbackModel({
    required this.carId,
    required this.carName,
    required this.carBrand,
    required this.carImage,
    required this.feedbacks,
    this.bookingId,
  });

   
  FeedbackEntity toEntity() {
    return FeedbackEntity(
      carId: carId,
      carName: carName,
      carBrand: carBrand,
      carImage: carImage,
      feedbacks: feedbacks.map((f) => f.toEntity()).toList(),
      bookingId: bookingId,
    );
  }

   
  factory FeedbackModel.fromEntity(FeedbackEntity entity) {
    return FeedbackModel(
      carId: entity.carId,
      carName: entity.carName,
      carBrand: entity.carBrand,
      carImage: entity.carImage,
      feedbacks: entity.feedbacks.map((f) => FeedbackItemModel.fromEntity(f)).toList(),
      bookingId: entity.bookingId,
    );
  }
}

@HiveType(typeId: 3)
class FeedbackItemModel {
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

  FeedbackItemModel({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.userId,
  });

   
  FeedbackItemEntity toEntity() {
    return FeedbackItemEntity(
      userName: userName,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
      userId: userId,
    );
  }

   
  factory FeedbackItemModel.fromEntity(FeedbackItemEntity entity) {
    return FeedbackItemModel(
      userName: entity.userName,
      rating: entity.rating,
      comment: entity.comment,
      createdAt: entity.createdAt,
      userId: entity.userId,
    );
  }
}
