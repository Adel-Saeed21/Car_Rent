import 'package:carrent/feature/home/logic/home_state.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCategoryCubit extends Cubit<HomeCategoryState> {
  HomeCategoryCubit() : super(const HomeCategoryInitial()) {
    _initializeDefaultCars();
  }

  List<CarEntity> _currentCars = [];
  List<CarEntity> get currentCars => _currentCars;

   

  void _initializeDefaultCars() {
    _currentCars = getCarsByBrand('Mercedes');
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

  Future<void> selectCategory(String categoryName) async {
    final currentCat = currentCategory;
    if (currentCat == categoryName) return;

    try {
       
      emit(HomeCategoryLoading(selectedCategory: categoryName));

      await _loadCarsForCategory(categoryName);

      _currentCars = getCarsByBrand(categoryName);

      emit(
        HomeCategoryChanged(
          selectedCategory: categoryName,
          previousCategory: currentCat,
          timestamp: DateTime.now(),
        ),
      );
    } catch (e) {
      emit(
        HomeCategoryError(
          selectedCategory: currentCat,
          errorMessage: 'Failed to load cars for category: ${e.toString()}',
        ),
      );
    }
  }

  void resetToDefault() {
    _currentCars = getCarsByBrand('Mercedes');
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
    _currentCars = getCarsByBrand('Mercedes');
    emit(const HomeCategoryInitial());
  }

   

  List<CarEntity> searchCarsInCurrentCategory(String query) {
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
      
    }
  }
}