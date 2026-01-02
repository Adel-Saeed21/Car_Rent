import 'package:equatable/equatable.dart';

 
class FeedbackItemEntity extends Equatable {
  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final String userId;

  const FeedbackItemEntity({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.userId,
  });

   
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

  FeedbackItemEntity copyWith({
    String? userName,
    double? rating,
    String? comment,
    DateTime? createdAt,
    String? userId,
  }) {
    return FeedbackItemEntity(
      userName: userName ?? this.userName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [userName, rating, comment, createdAt, userId];
}

 
class FeedbackEntity extends Equatable {
  final String carId;
  final String carName;
  final String carBrand;
  final String carImage;
  final List<FeedbackItemEntity> feedbacks;
  final String? bookingId;

  const FeedbackEntity({
    required this.carId,
    required this.carName,
    required this.carBrand,
    required this.carImage,
    required this.feedbacks,
    this.bookingId,
  });

   
  double get averageRating {
    if (feedbacks.isEmpty) return 0.0;
    final totalRating = feedbacks.fold<double>(
      0.0,
      (sum, feedback) => sum + feedback.rating,
    );
    return totalRating / feedbacks.length;
  }

   
  int get totalReviews => feedbacks.length;

   
  bool hasUserFeedback(String userId) {
    return feedbacks.any((feedback) => feedback.userId == userId);
  }

   
  FeedbackItemEntity? getUserFeedback(String userId) {
    try {
      return feedbacks.firstWhere((feedback) => feedback.userId == userId);
    } catch (e) {
      return null;
    }
  }

  FeedbackEntity addFeedback(FeedbackItemEntity feedback) {
    return FeedbackEntity(
      carId: carId,
      carName: carName,
      carBrand: carBrand,
      carImage: carImage,
      feedbacks: [...feedbacks, feedback],
      bookingId: bookingId,
    );
  }

  FeedbackEntity updateFeedback(String userId, FeedbackItemEntity updatedFeedback) {
    final updatedFeedbacks = feedbacks.map((feedback) {
      if (feedback.userId == userId) {
        return updatedFeedback;
      }
      return feedback;
    }).toList();

    return FeedbackEntity(
      carId: carId,
      carName: carName,
      carBrand: carBrand,
      carImage: carImage,
      feedbacks: updatedFeedbacks,
      bookingId: bookingId,
    );
  }

  FeedbackEntity copyWith({
    String? carId,
    String? carName,
    String? carBrand,
    String? carImage,
    List<FeedbackItemEntity>? feedbacks,
    String? bookingId,
  }) {
    return FeedbackEntity(
      carId: carId ?? this.carId,
      carName: carName ?? this.carName,
      carBrand: carBrand ?? this.carBrand,
      carImage: carImage ?? this.carImage,
      feedbacks: feedbacks ?? this.feedbacks,
      bookingId: bookingId ?? this.bookingId,
    );
  }

  @override
  List<Object?> get props => [
        carId,
        carName,
        carBrand,
        carImage,
        feedbacks,
        bookingId,
      ];
}
