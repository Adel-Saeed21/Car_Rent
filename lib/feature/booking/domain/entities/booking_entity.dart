import 'package:equatable/equatable.dart';

 
enum BookingStatus {
  active,
  completed,
  cancelled,
}

 
class BookingEntity extends Equatable {
  final String id;
  final String carId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime bookingTime;
  final BookingStatus status;

  const BookingEntity({
    required this.id,
    required this.carId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.bookingTime,
    this.status = BookingStatus.active,
  });

   
  bool get isActive => status == BookingStatus.active;

   
  bool get isCompleted => status == BookingStatus.completed;

   
  bool get isExpired {
    return DateTime.now().isAfter(endDate) && status == BookingStatus.active;
  }

   
  int get totalDays {
    return endDate.difference(startDate).inDays + 1;
  }

  BookingEntity copyWith({
    String? id,
    String? carId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? bookingTime,
    BookingStatus? status,
  }) {
    return BookingEntity(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      bookingTime: bookingTime ?? this.bookingTime,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        carId,
        userId,
        startDate,
        endDate,
        bookingTime,
        status,
      ];
}
