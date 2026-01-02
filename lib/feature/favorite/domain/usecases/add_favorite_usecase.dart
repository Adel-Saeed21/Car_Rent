import 'package:carrent/feature/favorite/domain/repositories/i_favorite_repository.dart';

 
class AddFavoriteUseCase {
  final IFavoriteRepository _repository;

  AddFavoriteUseCase(this._repository);

  Future<void> call(String userId, String carId) async {
    await _repository.addFavorite(userId, carId);
  }
}
