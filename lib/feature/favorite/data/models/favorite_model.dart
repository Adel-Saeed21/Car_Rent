import 'package:carrent/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 5)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String carId;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final DateTime addedAt;

  FavoriteModel({
    required this.id,
    required this.carId,
    required this.userId,
    required this.addedAt,
  });

   
  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: id,
      carId: carId,
      userId: userId,
      addedAt: addedAt,
    );
  }

   
  factory FavoriteModel.fromEntity(FavoriteEntity entity) {
    return FavoriteModel(
      id: entity.id,
      carId: entity.carId,
      userId: entity.userId,
      addedAt: entity.addedAt,
    );
  }
}
