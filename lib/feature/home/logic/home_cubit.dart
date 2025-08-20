import 'package:carrent/feature/home/logic/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCategoryCubit extends Cubit<HomeCategoryState> {
  HomeCategoryCubit() : super(const HomeCategoryInitial());

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
      emit(HomeCategoryLoading(selectedCategory: currentCat));
      
      
      await _loadCarsForCategory(categoryName);
      emit(HomeCategoryChanged(
        selectedCategory: categoryName,
        previousCategory: currentCat,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(HomeCategoryError(
        selectedCategory: currentCat,
        errorMessage: 'Failed to load cars for category: ${e.toString()}',
      ));
    }
  }

  void resetToDefault() {
    emit(const HomeCategoryInitial());
  }

  void setError(String errorMessage) {
    emit(HomeCategoryError(
      selectedCategory: currentCategory,
      errorMessage: errorMessage,
    ));
  }

  Future<void> _loadCarsForCategory(String categoryName) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
  }
  void refreshCategories() {
    emit(const HomeCategoryInitial());
  }
}