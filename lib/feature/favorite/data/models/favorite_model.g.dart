 

part of 'favorite_model.dart';

 
 
 

class FavoriteModelAdapter extends TypeAdapter<FavoriteModel> {
  @override
  final int typeId = 5;

  @override
  FavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteModel(
      id: fields[0] as String,
      carId: fields[1] as String,
      userId: fields[2] as String,
      addedAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.carId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
