import 'package:carrent/feature/home/data/car_model.dart';
import 'package:equatable/equatable.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object?> get props => [];
}

class FavouriteInitial extends FavouriteState {
  const FavouriteInitial();
}

class FavouriteLoading extends FavouriteState {
  const FavouriteLoading();
}

class FavouriteLoaded extends FavouriteState {
  final List<CarModel> favouriteCars;
  final DateTime timestamp;

  const FavouriteLoaded({
    required this.favouriteCars,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [favouriteCars, timestamp];

  bool get isEmpty => favouriteCars.isEmpty;
  bool get isNotEmpty => favouriteCars.isNotEmpty;
  int get count => favouriteCars.length;
}

class FavouriteError extends FavouriteState {
  final String errorMessage;
  final List<CarModel> cachedCars;

  const FavouriteError({
    required this.errorMessage,
    this.cachedCars = const [],
  });

  @override
  List<Object?> get props => [errorMessage, cachedCars];
}

class FavouriteCarToggled extends FavouriteState {
  final String carId;
  final bool isFavourite;
  final List<CarModel> updatedFavourites;
  final DateTime timestamp;

  const FavouriteCarToggled({
    required this.carId,
    required this.isFavourite,
    required this.updatedFavourites,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [carId, isFavourite, updatedFavourites, timestamp];
}

class FavouriteSearchResults extends FavouriteState {
  final List<CarModel> searchResults;
  final String searchQuery;
  final List<CarModel> originalFavourites;

  const FavouriteSearchResults({
    required this.searchResults,
    required this.searchQuery,
    required this.originalFavourites,
  });

  @override
  List<Object?> get props => [searchResults, searchQuery, originalFavourites];

  bool get hasResults => searchResults.isNotEmpty;
  bool get isEmpty => searchResults.isEmpty;
}