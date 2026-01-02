import 'package:carrent/feature/favorite/domain/repositories/i_favorite_repository.dart';

 
class RemoveFavoriteUseCase {
  final IFavoriteRepository _repository;

  RemoveFavoriteUseCase(this._repository);

  Future<void> call(String userId, String carId) async {
    await _repository.removeFavorite(userId, carId);
  }
}
