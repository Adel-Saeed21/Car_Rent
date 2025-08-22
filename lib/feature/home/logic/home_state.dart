import 'package:carrent/feature/home/data/car_model.dart';

abstract class HomeCategoryState {
  const HomeCategoryState();
}

class HomeCategoryInitial extends HomeCategoryState {
  final String selectedCategory;

  const HomeCategoryInitial({this.selectedCategory = 'Mercedes'});
}

class HomeCategoryLoading extends HomeCategoryState {
  final String selectedCategory;

  const HomeCategoryLoading({required this.selectedCategory});
}

class HomeCategoryChanged extends HomeCategoryState {
  final String selectedCategory;
  final String previousCategory;
  final DateTime timestamp;

  const HomeCategoryChanged({
    required this.selectedCategory,
    required this.previousCategory,
    required this.timestamp,
  });
}

class HomeCategoryError extends HomeCategoryState {
  final String selectedCategory;
  final String errorMessage;

  const HomeCategoryError({
    required this.selectedCategory,
    required this.errorMessage,
  });
}

class FavoriteToggled extends HomeCategoryState {
  final CarModel car;

  FavoriteToggled(this.car);
}
