import 'package:carrent/feature/booking/domain/entities/booking_entity.dart';

 
abstract class IBookingRepository {
   
  Future<void> createBooking(BookingEntity booking);

   
  Future<List<BookingEntity>> getUserBookings(String userId);

   
  Future<BookingEntity?> getBookingById(String bookingId);

   
  Future<List<BookingEntity>> getCarBookings(String carId);

   
  Future<void> updateBookingStatus(String bookingId, BookingStatus status);

   
  Future<void> cancelBooking(String bookingId);

   
  Future<List<BookingEntity>> getActiveBookings(String userId);

   
  Future<List<BookingEntity>> getCompletedBookings(String userId);

   
  Future<void> updateExpiredBookings();

   
  Future<void> deleteBooking(String bookingId);
}
