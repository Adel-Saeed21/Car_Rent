import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:carrent/feature/favourite_items/data/repo/i_favourite_repo.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:hive/hive.dart';
import 'dart:async';

class FavouriteRepository implements IFavouriteRepo {
  static const String _userBoxName = 'UserDataBox';
  static const String _currentUserKey = 'currentUser';
  
  Box<UserData>? _userBox;
  final StreamController<List<String>> _favouriteIdsController = 
      StreamController<List<String>>.broadcast();

  Future<Box<UserData>> get userBox async {
    _userBox ??= await Hive.openBox<UserData>(_userBoxName);
    return _userBox!;
  }

  // Get current user data
  Future<UserData?> _getCurrentUser() async {
    final box = await userBox;
    return box.get(_currentUserKey);
  }

  // Save current user data
  Future<void> _saveCurrentUser(UserData userData) async {
    final box = await userBox;
    await box.put(_currentUserKey, userData);
    
    // Emit changes to stream
    _favouriteIdsController.add(userData.favouriteCarsId ?? []);
  }

  @override
  Future<List<CarModel>> getFavouriteCars() async {
    try {
      final currentUser = await _getCurrentUser();
      if (currentUser?.favouriteCarsId == null || 
          currentUser!.favouriteCarsId!.isEmpty) {
        return [];
      }

      List<CarModel> favouriteCars = [];
      
      for (String category in carsData.keys) {
        final categoryCars = getCarsByBrand(category);
        final matchingCars = categoryCars.where(
          (car) => currentUser.favouriteCarsId!.contains(car.id)
        ).toList();
        
        final favoriteMarkedCars = matchingCars.map(
          (car) => car.copyWith(isFavorite: true)
        ).toList();
        
        favouriteCars.addAll(favoriteMarkedCars);
      }

      return favouriteCars;
    } catch (e) {
      throw Exception('Failed to get favourite cars: $e');
    }
  }

  @override
  Future<void> addCarToFavourites(String carId) async {
    try {
      final currentUser = await _getCurrentUser();
      if (currentUser == null) {
        throw Exception('No current user found');
      }

      List<String> favorites = List.from(currentUser.favouriteCarsId ?? []);
      
      if (!favorites.contains(carId)) {
        favorites.add(carId);
        
        final updatedUser = UserData(
          uid: currentUser.uid,
          email: currentUser.email,
          name: currentUser.name,
          phone: currentUser.phone,
          favouriteCarsId: favorites,
          profileImagePath: currentUser.profileImagePath,
        );
        
        await _saveCurrentUser(updatedUser);
      }
    } catch (e) {
      throw Exception('Failed to add car to favourites: $e');
    }
  }

  @override
  Future<void> removeCarFromFavourites(String carId) async {
    try {
      final currentUser = await _getCurrentUser();
      if (currentUser == null) {
        throw Exception('No current user found');
      }

      List<String> favorites = List.from(currentUser.favouriteCarsId ?? []);
      favorites.remove(carId);
      
      final updatedUser = UserData(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.name,
        phone: currentUser.phone,
        favouriteCarsId: favorites,
        profileImagePath: currentUser.profileImagePath,
      );
      
      await _saveCurrentUser(updatedUser);
    } catch (e) {
      throw Exception('Failed to remove car from favourites: $e');
    }
  }

  @override
  Future<bool> isCarFavourite(String carId) async {
    try {
      final currentUser = await _getCurrentUser();
      if (currentUser?.favouriteCarsId == null) return false;
      
      return currentUser!.favouriteCarsId!.contains(carId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearAllFavourites() async {
    try {
      final currentUser = await _getCurrentUser();
      if (currentUser == null) {
        throw Exception('No current user found');
      }

      final updatedUser = UserData(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.name,
        phone: currentUser.phone,
        favouriteCarsId: [], 
        profileImagePath: currentUser.profileImagePath,
      );
      
      await _saveCurrentUser(updatedUser);
    } catch (e) {
      throw Exception('Failed to clear all favourites: $e');
    }
  }

  @override
  Stream<List<String>> watchFavouriteCarIds() {
    return _favouriteIdsController.stream;
  }

  Future<void> initializeStream() async {
    final currentUser = await _getCurrentUser();
    _favouriteIdsController.add(currentUser?.favouriteCarsId ?? []);
  }

  void dispose() {
    _favouriteIdsController.close();
  }
}