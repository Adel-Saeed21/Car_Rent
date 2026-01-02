 

part of 'feedback_model.dart';

 
 
 

class FeedbackModelAdapter extends TypeAdapter<FeedbackModel> {
  @override
  final int typeId = 2;

  @override
  FeedbackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedbackModel(
      carId: fields[0] as String,
      carName: fields[1] as String,
      carBrand: fields[2] as String,
      carImage: fields[3] as String,
      feedbacks: (fields[4] as List).cast<FeedbackItemModel>(),
      bookingId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FeedbackModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.carId)
      ..writeByte(1)
      ..write(obj.carName)
      ..writeByte(2)
      ..write(obj.carBrand)
      ..writeByte(3)
      ..write(obj.carImage)
      ..writeByte(4)
      ..write(obj.feedbacks)
      ..writeByte(5)
      ..write(obj.bookingId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FeedbackItemModelAdapter extends TypeAdapter<FeedbackItemModel> {
  @override
  final int typeId = 3;

  @override
  FeedbackItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedbackItemModel(
      userName: fields[0] as String,
      rating: fields[1] as double,
      comment: fields[2] as String,
      createdAt: fields[3] as DateTime,
      userId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FeedbackItemModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.rating)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
