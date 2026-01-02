import 'package:carrent/feature/favorite/data/models/favorite_model.dart';
import 'package:hive/hive.dart';

 
class FavoriteLocalDataSource {
  static const String _boxName = 'favorites';

   
  Future<Box<FavoriteModel>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<FavoriteModel>(_boxName);
    }
    return Hive.box<FavoriteModel>(_boxName);
  }

   
  Future<void> addFavorite(FavoriteModel favorite) async {
    final box = await _getBox();
    await box.put(favorite.id, favorite);
  }

   
  Future<void> removeFavorite(String favoriteId) async {
    final box = await _getBox();
    await box.delete(favoriteId);
  }

   
  Future<List<FavoriteModel>> getFavoritesByUserId(String userId) async {
    final box = await _getBox();
    return box.values.where((fav) => fav.userId == userId).toList();
  }

   
  Future<bool> isFavorite(String userId, String carId) async {
    final box = await _getBox();
    return box.values.any((fav) => fav.userId == userId && fav.carId == carId);
  }

   
  Future<FavoriteModel?> getFavorite(String userId, String carId) async {
    final box = await _getBox();
    try {
      return box.values.firstWhere(
        (fav) => fav.userId == userId && fav.carId == carId,
      );
    } catch (e) {
      return null;
    }
  }

   
  Future<void> clearFavorites(String userId) async {
    final box = await _getBox();
    final favoritesToDelete = box.values
        .where((fav) => fav.userId == userId)
        .map((fav) => fav.id)
        .toList();

    for (final id in favoritesToDelete) {
      await box.delete(id);
    }
  }
}
