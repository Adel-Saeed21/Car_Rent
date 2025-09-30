import 'package:carrent/feature/home/data/car_model.dart';

abstract class IFavouriteRepo {
  Future<List<CarModel>> getFavouriteCars();
  Future<void> addCarToFavourites(String carId);
  Future<void> removeCarFromFavourites(String carId);
  Future<bool> isCarFavourite(String carId);
  Future<void> clearAllFavourites();
  Stream<List<String>> watchFavouriteCarIds();
}