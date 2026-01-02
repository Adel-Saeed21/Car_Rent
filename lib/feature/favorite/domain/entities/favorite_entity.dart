import 'package:equatable/equatable.dart';

 
class FavoriteEntity extends Equatable {
  final String id;
  final String carId;
  final String userId;
  final DateTime addedAt;

  const FavoriteEntity({
    required this.id,
    required this.carId,
    required this.userId,
    required this.addedAt,
  });

  FavoriteEntity copyWith({
    String? id,
    String? carId,
    String? userId,
    DateTime? addedAt,
  }) {
    return FavoriteEntity(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      userId: userId ?? this.userId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  List<Object?> get props => [id, carId, userId, addedAt];
}
