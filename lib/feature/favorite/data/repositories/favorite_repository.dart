import 'package:carrent/feature/favorite/data/datasources/favorite_local_data_source.dart';
import 'package:carrent/feature/car/data/datasources/car_local_data_source.dart';
import 'package:carrent/feature/favorite/data/models/favorite_model.dart';
import 'package:carrent/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/favorite/domain/repositories/i_favorite_repository.dart';

 
class FavoriteRepository implements IFavoriteRepository {
  final FavoriteLocalDataSource _localDataSource;
  final CarLocalDataSource _carDataSource;

  FavoriteRepository(this._localDataSource, this._carDataSource);

  @override
  Future<void> addFavorite(String userId, String carId) async {
    final favorite = FavoriteModel(
      id: '${userId}_$carId',
      carId: carId,
      userId: userId,
      addedAt: DateTime.now(),
    );
    await _localDataSource.addFavorite(favorite);
  }

  @override
  Future<void> removeFavorite(String userId, String carId) async {
    final favoriteId = '${userId}_$carId';
    await _localDataSource.removeFavorite(favoriteId);
  }

  @override
  Future<bool> isFavorite(String userId, String carId) async {
    return await _localDataSource.isFavorite(userId, carId);
  }

  @override
  Future<List<String>> getFavoriteCarIds(String userId) async {
    final favorites = await _localDataSource.getFavoritesByUserId(userId);
    return favorites.map((fav) => fav.carId).toList();
  }

  @override
  Future<List<FavoriteEntity>> getFavorites(String userId) async {
    final favorites = await _localDataSource.getFavoritesByUserId(userId);
    return favorites.map((fav) => fav.toEntity()).toList();
  }

  @override
  Future<List<CarEntity>> getFavoriteCars(String userId) async {
    final favoriteCarIds = await getFavoriteCarIds(userId);
    final allCars = _carDataSource.getAllCars();
    
    return allCars
        .where((car) => favoriteCarIds.contains(car.id))
        .map((car) => car.toEntity())
        .toList();
  }

  @override
  Future<void> clearFavorites(String userId) async {
    await _localDataSource.clearFavorites(userId);
  }
}
