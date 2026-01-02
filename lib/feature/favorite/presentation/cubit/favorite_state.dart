import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:equatable/equatable.dart';

 
abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

 
class FavoriteInitial extends FavoriteState {}

 
class FavoriteLoading extends FavoriteState {}

 
class FavoriteLoaded extends FavoriteState {
  final List<CarEntity> favoriteCars;

  FavoriteLoaded(this.favoriteCars);

  @override
  List<Object?> get props => [favoriteCars];
}

 
class FavoriteEmpty extends FavoriteState {}

 
class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);

  @override
  List<Object?> get props => [message];
}

 
class FavoriteToggled extends FavoriteState {
  final String carId;
  final bool isFavorite;

  FavoriteToggled(this.carId, this.isFavorite);

  @override
  List<Object?> get props => [carId, isFavorite];
}
