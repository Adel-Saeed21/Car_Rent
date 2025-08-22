import 'package:carrent/feature/home/logic/home_state.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCategoryCubit extends Cubit<HomeCategoryState> {
  HomeCategoryCubit() : super(const HomeCategoryInitial()) {
    _initializeDefaultCars();
  }

  List<CarModel> _currentCars = [];
  List<CarModel> get currentCars => _currentCars;

  final Map<String, bool> _favoriteStatus = {};

  void _initializeDefaultCars() {
    _currentCars = _getCarsWithFavoriteStatus('Mercedes');
  }

  String get currentCategory {
    if (state is HomeCategoryInitial) {
      return (state as HomeCategoryInitial).selectedCategory;
    } else if (state is HomeCategoryLoading) {
      return (state as HomeCategoryLoading).selectedCategory;
    } else if (state is HomeCategoryChanged) {
      return (state as HomeCategoryChanged).selectedCategory;
    } else if (state is HomeCategoryError) {
      return (state as HomeCategoryError).selectedCategory;
    }
    return 'Mercedes';
  }

  // دالة لجلب السيارات مع حفظ حالة الـ favorites
  List<CarModel> _getCarsWithFavoriteStatus(String categoryName) {
    final cars = getCarsByBrand(categoryName);
    return cars.map((car) {
      final isFavorite = _favoriteStatus[car.id] ?? false;
      return car.copyWith(isFavorite: isFavorite);
    }).toList();
  }

  Future<void> selectCategory(String categoryName) async {
    final currentCat = currentCategory;
    if (currentCat == categoryName) return;

    try {
      // Emit loading state
      emit(HomeCategoryLoading(selectedCategory: categoryName));

      // Simulate API call delay
      await _loadCarsForCategory(categoryName);

      // Get cars for the selected category with preserved favorite status
      _currentCars = _getCarsWithFavoriteStatus(categoryName);

      // Emit success state
      emit(
        HomeCategoryChanged(
          selectedCategory: categoryName,
          previousCategory: currentCat,
          timestamp: DateTime.now(),
        ),
      );
    } catch (e) {
      // Emit error state
      emit(
        HomeCategoryError(
          selectedCategory: currentCat,
          errorMessage: 'Failed to load cars for category: ${e.toString()}',
        ),
      );
    }
  }

  void resetToDefault() {
    _currentCars = _getCarsWithFavoriteStatus('Mercedes');
    emit(const HomeCategoryInitial());
  }

  void setError(String errorMessage) {
    emit(
      HomeCategoryError(
        selectedCategory: currentCategory,
        errorMessage: errorMessage,
      ),
    );
  }

  Future<void> _loadCarsForCategory(String categoryName) async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  void refreshCategories() {
    _currentCars = _getCarsWithFavoriteStatus('Mercedes');
    emit(const HomeCategoryInitial());
  }

  // تحديث حالة الـ favorite للسيارة
  void toggleCarFavorite(String carId) {
    final carIndex = _currentCars.indexWhere((car) => car.id == carId);
    if (carIndex != -1) {
      // تحديث حالة الـ favorite في الخريطة العامة
      final currentFavoriteStatus = _favoriteStatus[carId] ?? false;
      _favoriteStatus[carId] = !currentFavoriteStatus;

      // تحديث السيارة في القائمة الحالية
      final updatedCar = _currentCars[carIndex].copyWith(
        isFavorite: _favoriteStatus[carId],
      );

      _currentCars[carIndex] = updatedCar;

      final currentState = state;
      if (currentState is HomeCategoryChanged) {
        emit(
          HomeCategoryChanged(
            selectedCategory: currentState.selectedCategory,
            previousCategory: currentState.previousCategory,
            timestamp: DateTime.now(),
          ),
        );
      } else if (currentState is HomeCategoryInitial) {
        emit(HomeCategoryInitial(selectedCategory: currentCategory));
      }
    }
  }

  List<CarModel> getFavoriteCarsFromCurrentCategory() {
    return _currentCars.where((car) => car.isFavorite).toList();
  }

  List<CarModel> getAllFavoriteCars() {
    List<CarModel> allFavorites = [];

    for (String category in carsData.keys) {
      final categoryCars = _getCarsWithFavoriteStatus(category);
      allFavorites.addAll(categoryCars.where((car) => car.isFavorite));
    }

    return allFavorites;
  }

  List<CarModel> searchCarsInCurrentCategory(String query) {
    if (query.isEmpty) return _currentCars;
    return _currentCars.where((car) {
      return car.name.toLowerCase().contains(query.toLowerCase()) ||
          car.brand.toLowerCase().contains(query.toLowerCase()) ||
          car.features.any(
            (feature) => feature.toLowerCase().contains(query.toLowerCase()),
          );
    }).toList();
  }

  @override
  void onChange(Change<HomeCategoryState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print('HomeCategoryCubit State Changed: ${change.currentState}');
    }
  }
}
