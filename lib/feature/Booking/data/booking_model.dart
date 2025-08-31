import 'package:hive/hive.dart';
part 'booking_model.g.dart';
@HiveType(typeId: 1)
class BookingModel extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String carId;
  
  @HiveField(2)
  String userId;
  
  @HiveField(3)
  DateTime startDate;
  
  @HiveField(4)
  DateTime endDate;
  
  @HiveField(5)
  DateTime bookingTime;
  
  @HiveField(6)
  BookingStatus status;

  BookingModel({
    required this.id,
    required this.carId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.bookingTime,
    this.status = BookingStatus.active,
  });
}

@HiveType(typeId: 4)
enum BookingStatus {
  @HiveField(0)
  active,
  @HiveField(1)
  completed,
  @HiveField(2)
  cancelled,
}