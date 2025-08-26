// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
      feedbacks: (fields[4] as List).cast<FeedbackItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, FeedbackModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.carId)
      ..writeByte(1)
      ..write(obj.carName)
      ..writeByte(2)
      ..write(obj.carBrand)
      ..writeByte(3)
      ..write(obj.carImage)
      ..writeByte(4)
      ..write(obj.feedbacks);
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

class FeedbackItemAdapter extends TypeAdapter<FeedbackItem> {
  @override
  final int typeId = 3;

  @override
  FeedbackItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedbackItem(
      userName: fields[0] as String,
      rating: fields[1] as double,
      comment: fields[2] as String,
      createdAt: fields[3] as DateTime,
      userId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FeedbackItem obj) {
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
      other is FeedbackItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackModel _$FeedbackModelFromJson(Map<String, dynamic> json) =>
    FeedbackModel(
      carId: json['carId'] as String,
      carName: json['carName'] as String,
      carBrand: json['carBrand'] as String,
      carImage: json['carImage'] as String,
      feedbacks: (json['feedbacks'] as List<dynamic>)
          .map((e) => FeedbackItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedbackModelToJson(FeedbackModel instance) =>
    <String, dynamic>{
      'carId': instance.carId,
      'carName': instance.carName,
      'carBrand': instance.carBrand,
      'carImage': instance.carImage,
      'feedbacks': instance.feedbacks,
    };

FeedbackItem _$FeedbackItemFromJson(Map<String, dynamic> json) => FeedbackItem(
      userName: json['userName'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$FeedbackItemToJson(FeedbackItem instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
      'userId': instance.userId,
    };
