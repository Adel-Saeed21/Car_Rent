 

part of 'booking_model.dart';

 
 
 

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
      status: fields[6] as BookingStatusModel,
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

class BookingStatusModelAdapter extends TypeAdapter<BookingStatusModel> {
  @override
  final int typeId = 4;

  @override
  BookingStatusModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BookingStatusModel.active;
      case 1:
        return BookingStatusModel.completed;
      case 2:
        return BookingStatusModel.cancelled;
      default:
        return BookingStatusModel.active;
    }
  }

  @override
  void write(BinaryWriter writer, BookingStatusModel obj) {
    switch (obj) {
      case BookingStatusModel.active:
        writer.writeByte(0);
        break;
      case BookingStatusModel.completed:
        writer.writeByte(1);
        break;
      case BookingStatusModel.cancelled:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
