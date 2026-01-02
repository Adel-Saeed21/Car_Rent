import 'package:carrent/feature/booking/domain/entities/booking_entity.dart';
import 'package:hive/hive.dart';

part 'booking_model.g.dart';

@HiveType(typeId: 1)
class BookingModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String carId;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  final DateTime endDate;

  @HiveField(5)
  final DateTime bookingTime;

  @HiveField(6)
  final BookingStatusModel status;

  BookingModel({
    required this.id,
    required this.carId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.bookingTime,
    this.status = BookingStatusModel.active,
  });

   
  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      carId: carId,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      bookingTime: bookingTime,
      status: _statusToEntity(status),
    );
  }

   
  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      carId: entity.carId,
      userId: entity.userId,
      startDate: entity.startDate,
      endDate: entity.endDate,
      bookingTime: entity.bookingTime,
      status: _statusFromEntity(entity.status),
    );
  }

  static BookingStatus _statusToEntity(BookingStatusModel status) {
    switch (status) {
      case BookingStatusModel.active:
        return BookingStatus.active;
      case BookingStatusModel.completed:
        return BookingStatus.completed;
      case BookingStatusModel.cancelled:
        return BookingStatus.cancelled;
    }
  }

  static BookingStatusModel _statusFromEntity(BookingStatus status) {
    switch (status) {
      case BookingStatus.active:
        return BookingStatusModel.active;
      case BookingStatus.completed:
        return BookingStatusModel.completed;
      case BookingStatus.cancelled:
        return BookingStatusModel.cancelled;
    }
  }
}

@HiveType(typeId: 4)
enum BookingStatusModel {
  @HiveField(0)
  active,
  @HiveField(1)
  completed,
  @HiveField(2)
  cancelled,
}
