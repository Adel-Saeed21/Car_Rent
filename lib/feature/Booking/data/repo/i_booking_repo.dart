// lib/feature/booking/data/booking_repository.dart
import 'package:carrent/feature/Booking/data/booking_model.dart';

abstract class IBookingRepository {
  Future<void> init();
  Future<String> createBooking(String carId, String userId, DateTime startDate, DateTime endDate);
  List<BookingModel> getUserBookings(String userId);
  List<BookingModel> getCarBookings(String carId);
  bool canBookCar(String carId, DateTime startDate, DateTime endDate);
  Future<void> updateBookingStatus(String bookingId, BookingStatus status);
  BookingModel? getBooking(String bookingId);
}