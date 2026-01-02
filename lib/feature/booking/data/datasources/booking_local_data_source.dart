import 'package:carrent/feature/booking/data/models/booking_model.dart';
import 'package:hive/hive.dart';

 
class BookingLocalDataSource {
  static const String _boxName = 'bookings';

   
  Future<Box<BookingModel>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<BookingModel>(_boxName);
    }
    return Hive.box<BookingModel>(_boxName);
  }

   
  Future<void> saveBooking(BookingModel booking) async {
    final box = await _getBox();
    await box.put(booking.id, booking);
  }

   
  Future<BookingModel?> getBookingById(String bookingId) async {
    final box = await _getBox();
    return box.get(bookingId);
  }

   
  Future<List<BookingModel>> getBookingsByUserId(String userId) async {
    final box = await _getBox();
    return box.values.where((booking) => booking.userId == userId).toList();
  }

   
  Future<List<BookingModel>> getBookingsByCarId(String carId) async {
    final box = await _getBox();
    return box.values.where((booking) => booking.carId == carId).toList();
  }

   
  Future<List<BookingModel>> getAllBookings() async {
    final box = await _getBox();
    return box.values.toList();
  }

   
  Future<void> deleteBooking(String bookingId) async {
    final box = await _getBox();
    await box.delete(bookingId);
  }

   
  Future<void> updateBooking(BookingModel booking) async {
    final box = await _getBox();
    await box.put(booking.id, booking);
  }
}
