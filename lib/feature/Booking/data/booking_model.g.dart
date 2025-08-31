// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingModelAdapter extends TypeAdapter<BookingModel> {
  @override
  final int typeId = 1;

  @override
  BookingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingModel(
      id: fields[0] as String,
      carId: fields[1] as String,
      userId: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime,
      bookingTime: fields[5] as DateTime,
      status: fields[6] as BookingStatus,
    );
  }

  @override
  void write(BinaryWriter writer, BookingModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.carId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.bookingTime)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BookingStatusAdapter extends TypeAdapter<BookingStatus> {
  @override
  final int typeId = 4;

  @override
  BookingStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BookingStatus.active;
      case 1:
        return BookingStatus.completed;
      case 2:
        return BookingStatus.cancelled;
      default:
        return BookingStatus.active;
    }
  }

  @override
  void write(BinaryWriter writer, BookingStatus obj) {
    switch (obj) {
      case BookingStatus.active:
        writer.writeByte(0);
        break;
      case BookingStatus.completed:
        writer.writeByte(1);
        break;
      case BookingStatus.cancelled:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
