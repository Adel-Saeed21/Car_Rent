import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/favorite/domain/repositories/i_favorite_repository.dart';

 
class GetFavoritesUseCase {
  final IFavoriteRepository _repository;

  GetFavoritesUseCase(this._repository);

  Future<List<CarEntity>> call(String userId) async {
    return await _repository.getFavoriteCars(userId);
  }
}
