import 'package:carrent/feature/feedback/domain/repositories/i_feedback_repository.dart';

 
class AddFeedbackParams {
  final String carId;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final String? bookingId;

  AddFeedbackParams({
    required this.carId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    this.bookingId,
  });
}

 
class AddFeedbackUseCase {
  final IFeedbackRepository _repository;

  AddFeedbackUseCase(this._repository);

  Future<void> call(AddFeedbackParams params) async {
    await _repository.addFeedback(
      carId: params.carId,
      userId: params.userId,
      userName: params.userName,
      rating: params.rating,
      comment: params.comment,
      bookingId: params.bookingId,
    );
  }
}
