import 'package:carrent/feature/feedback/domain/entities/feedback_entity.dart';
import 'package:carrent/feature/feedback/domain/repositories/i_feedback_repository.dart';

 
class GetCarFeedbacksUseCase {
  final IFeedbackRepository _repository;

  GetCarFeedbacksUseCase(this._repository);

  Future<FeedbackEntity?> call(String carId) async {
    return await _repository.getCarFeedback(carId);
  }
}
