import 'dart:async';

import 'package:carrent/feature/favourite_items/data/repo/i_favourite_repo.dart';
import 'package:carrent/feature/favourite_items/logic/favourite_state.dart';
import 'package:carrent/feature/home/data/car_model.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final IFavouriteRepo _repository;
  StreamSubscription? _favouriteSubscription;
  List<CarModel> _cachedFavourites = [];

  FavouriteCubit(this._repository) : super(const FavouriteInitial()) {
    _initializeFavourites();
    _listenToFavouriteChanges();
  }

  Future<void> _initializeFavourites() async {
    await loadFavouriteCars();
  }

  void _listenToFavouriteChanges() {
    _favouriteSubscription = _repository.watchFavouriteCarIds().listen(
      (favouriteIds) async {
        if (state is! FavouriteLoading) {
          await _refreshFavouriteCars();
        }
      },
      onError: (error) {
        emit(FavouriteError(
          errorMessage: 'Failed to watch favourite changes: $error',
          cachedCars: _cachedFavourites,
        ));
      },
    );
  }

  // Load favourite cars from repository
  Future<void> loadFavouriteCars() async {
    try {
      emit(const FavouriteLoading());
      
      final favouriteCars = await _repository.getFavouriteCars();
      _cachedFavourites = favouriteCars;
      
      emit(FavouriteLoaded(
        favouriteCars: favouriteCars,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(FavouriteError(
        errorMessage: 'Failed to load favourite cars: ${e.toString()}',
        cachedCars: _cachedFavourites,
      ));
    }
  }

  // Refresh favourite cars without showing loading state
  Future<void> _refreshFavouriteCars() async {
    try {
      final favouriteCars = await _repository.getFavouriteCars();
      _cachedFavourites = favouriteCars;
      
      emit(FavouriteLoaded(
        favouriteCars: favouriteCars,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Error refreshing favourites: $e');
      }
    }
  }

  // Toggle car favourite status
  Future<void> toggleCarFavourite(String carId) async {
    try {
      final isCurrentlyFavourite = await _repository.isCarFavourite(carId);
      
      if (isCurrentlyFavourite) {
        await _repository.removeCarFromFavourites(carId);
      } else {
        await _repository.addCarToFavourites(carId);
      }

      // Refresh the list to reflect changes
      await _refreshFavouriteCars();
      
      emit(FavouriteCarToggled(
        carId: carId,
        isFavourite: !isCurrentlyFavourite,
        updatedFavourites: _cachedFavourites,
        timestamp: DateTime.now(),
      ));
      
    } catch (e) {
      emit(FavouriteError(
        errorMessage: 'Failed to toggle favourite: ${e.toString()}',
        cachedCars: _cachedFavourites,
      ));
    }
  }

  // Search in favourite cars
  void searchFavouriteCars(String query) {
    final currentState = state;
    List<CarModel> carsToSearch = [];
    
    if (currentState is FavouriteLoaded) {
      carsToSearch = currentState.favouriteCars;
    } else if (currentState is FavouriteSearchResults) {
      carsToSearch = currentState.originalFavourites;
    } else {
      carsToSearch = _cachedFavourites;
    }

    if (query.isEmpty) {
      emit(FavouriteLoaded(
        favouriteCars: carsToSearch,
        timestamp: DateTime.now(),
      ));
      return;
    }

    final filteredCars = carsToSearch.where((car) {
      return car.name.toLowerCase().contains(query.toLowerCase()) ||
          car.brand.toLowerCase().contains(query.toLowerCase()) ||
          car.features.any(
            (feature) => feature.toLowerCase().contains(query.toLowerCase()),
          );
    }).toList();

    emit(FavouriteSearchResults(
      searchResults: filteredCars,
      searchQuery: query,
      originalFavourites: carsToSearch,
    ));
  }

  void clearSearch() {
    if (state is FavouriteSearchResults) {
      final searchState = state as FavouriteSearchResults;
      emit(FavouriteLoaded(
        favouriteCars: searchState.originalFavourites,
        timestamp: DateTime.now(),
      ));
    }
  }

  Future<void> removeCarFromFavourites(String carId) async {
    try {
      await _repository.removeCarFromFavourites(carId);
      await _refreshFavouriteCars();
    } catch (e) {
      emit(FavouriteError(
        errorMessage: 'Failed to remove car from favourites: ${e.toString()}',
        cachedCars: _cachedFavourites,
      ));
    }
  }

  Future<void> clearAllFavourites() async {
    try {
      emit(const FavouriteLoading());
      await _repository.clearAllFavourites();
      _cachedFavourites = [];
      
      emit(FavouriteLoaded(
        favouriteCars: const [],
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(FavouriteError(
        errorMessage: 'Failed to clear all favourites: ${e.toString()}',
        cachedCars: _cachedFavourites,
      ));
    }
  }

  List<CarModel> get currentFavouriteCars {
    final currentState = state;
    if (currentState is FavouriteLoaded) {
      return currentState.favouriteCars;
    } else if (currentState is FavouriteSearchResults) {
      return currentState.originalFavourites;
    }
    return _cachedFavourites;
  }

  bool get hasFavourites => currentFavouriteCars.isNotEmpty;

  int get favouriteCount => currentFavouriteCars.length;

  Future<void> refresh() async {
    await loadFavouriteCars();
  }

  @override
  Future<void> close() {
    _favouriteSubscription?.cancel();
    return super.close();
  }

  @override
  void onChange(Change<FavouriteState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print('FavouriteCubit State Changed: ${change.currentState}');
    }
  }
}