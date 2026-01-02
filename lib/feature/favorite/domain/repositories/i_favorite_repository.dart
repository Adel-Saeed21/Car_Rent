import 'package:carrent/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';

 
abstract class IFavoriteRepository {
   
  Future<void> addFavorite(String userId, String carId);

   
  Future<void> removeFavorite(String userId, String carId);

   
  Future<bool> isFavorite(String userId, String carId);

   
  Future<List<String>> getFavoriteCarIds(String userId);

   
  Future<List<FavoriteEntity>> getFavorites(String userId);

   
  Future<List<CarEntity>> getFavoriteCars(String userId);

   
  Future<void> clearFavorites(String userId);
}
