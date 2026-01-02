import 'package:carrent/feature/feedback/domain/repositories/i_feedback_repository.dart';

 
class UpdateFeedbackParams {
  final String carId;
  final String userId;
  final double rating;
  final String comment;

  UpdateFeedbackParams({
    required this.carId,
    required this.userId,
    required this.rating,
    required this.comment,
  });
}

 
class UpdateFeedbackUseCase {
  final IFeedbackRepository _repository;

  UpdateFeedbackUseCase(this._repository);

  Future<void> call(UpdateFeedbackParams params) async {
    await _repository.updateFeedback(
      carId: params.carId,
      userId: params.userId,
      rating: params.rating,
      comment: params.comment,
    );
  }
}
