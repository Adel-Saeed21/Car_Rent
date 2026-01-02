import 'package:bloc/bloc.dart';
import 'package:carrent/feature/favorite/domain/usecases/add_favorite_usecase.dart';
import 'package:carrent/feature/favorite/domain/usecases/get_favorites_usecase.dart';
import 'package:carrent/feature/favorite/domain/usecases/is_favorite_usecase.dart';
import 'package:carrent/feature/favorite/domain/usecases/remove_favorite_usecase.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_state.dart';

 
class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoritesUseCase _getFavoritesUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;
  final IsFavoriteUseCase _isFavoriteUseCase;

  FavoriteCubit(
    this._getFavoritesUseCase,
    this._addFavoriteUseCase,
    this._removeFavoriteUseCase,
    this._isFavoriteUseCase,
  ) : super(FavoriteInitial());

   
  Future<void> loadFavorites(String userId) async {
    try {
      emit(FavoriteLoading());
      final favoriteCars = await _getFavoritesUseCase(userId);
      
      if (favoriteCars.isEmpty) {
        emit(FavoriteEmpty());
      } else {
        emit(FavoriteLoaded(favoriteCars));
      }
    } catch (e) {
      emit(FavoriteError('Failed to load favorites: ${e.toString()}'));
    }
  }

   
  Future<void> addFavorite(String userId, String carId) async {
    try {
      await _addFavoriteUseCase(userId, carId);
      emit(FavoriteToggled(carId, true));
       
      await loadFavorites(userId);
    } catch (e) {
      emit(FavoriteError('Failed to add favorite: ${e.toString()}'));
    }
  }

   
  Future<void> removeFavorite(String userId, String carId) async {
    try {
      await _removeFavoriteUseCase(userId, carId);
      emit(FavoriteToggled(carId, false));
       
      await loadFavorites(userId);
    } catch (e) {
      emit(FavoriteError('Failed to remove favorite: ${e.toString()}'));
    }
  }

   
  Future<void> toggleFavorite(String userId, String carId) async {
    try {
      final isFavorite = await _isFavoriteUseCase(userId, carId);
      
      if (isFavorite) {
        await removeFavorite(userId, carId);
      } else {
        await addFavorite(userId, carId);
      }
    } catch (e) {
      emit(FavoriteError('Failed to toggle favorite: ${e.toString()}'));
    }
  }

   
  Future<bool> isFavorite(String userId, String carId) async {
    try {
      return await _isFavoriteUseCase(userId, carId);
    } catch (e) {
      return false;
    }
  }
}
