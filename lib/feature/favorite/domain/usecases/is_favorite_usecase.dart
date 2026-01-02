import 'package:carrent/feature/favorite/domain/repositories/i_favorite_repository.dart';

 
class IsFavoriteUseCase {
  final IFavoriteRepository _repository;

  IsFavoriteUseCase(this._repository);

  Future<bool> call(String userId, String carId) async {
    return await _repository.isFavorite(userId, carId);
  }
}
