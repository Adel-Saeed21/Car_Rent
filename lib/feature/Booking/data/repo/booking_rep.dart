import 'package:carrent/feature/Booking/data/booking_model.dart';
import 'package:carrent/feature/Booking/data/repo/i_booking_repo.dart';
import 'package:hive/hive.dart';

class BookingRep extends IBookingRepository {
  static const String bookingBoxName = 'bookingBox';
  late Box<BookingModel> bookingBox;

  @override
  Future<void> init() async {
    bookingBox = await Hive.openBox<BookingModel>(bookingBoxName);
    await _updateExpiredBookings();
  }

  @override
  Future<String> createBooking(String carId, String userId, DateTime startDate, DateTime endDate) async {
    final bookingId = DateTime.now().millisecondsSinceEpoch.toString();
    final booking = BookingModel(
      id: bookingId,
      carId: carId,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      bookingTime: DateTime.now(),
      status: BookingStatus.active,
    );
    
    await bookingBox.put(bookingId, booking);
    return bookingId;
  }

  @override
  List<BookingModel> getCarBookings(String carId) {
    return bookingBox.values
        .where((booking) => booking.carId == carId)
        .toList();
  }

  @override
  List<BookingModel> getUserBookings(String userId) {
    return bookingBox.values
        .where((booking) => booking.userId == userId)
        .toList();
  }

  @override
  BookingModel? getBooking(String bookingId) {
    return bookingBox.get(bookingId);
  }

  @override
  Future<void> updateBookingStatus(String bookingId, BookingStatus status) async {
    final booking = getBooking(bookingId);
    if (booking != null) {
      booking.status = status;
      await booking.save();
    }
  }

  bool datesOverlap(DateTime start1, DateTime end1, DateTime start2, DateTime end2) {
    return start1.isBefore(end2.add(const Duration(days: 1))) &&
        end1.add(const Duration(days: 1)).isAfter(start2);
  }

  @override
  bool canBookCar(String carId, DateTime startDate, DateTime endDate) {
    _updateExpiredBookings();
    
    final carBookings = getCarBookings(carId)
        .where((booking) => booking.status == BookingStatus.active)
        .toList();

    for (final booking in carBookings) {
      if (datesOverlap(startDate, endDate, booking.startDate, booking.endDate)) {
        return false;
      }
    }
    return true;
  }

  Future<void> _updateExpiredBookings() async {
    final now = DateTime.now();
    final allBookings = bookingBox.values.toList();

    for (final booking in allBookings) {
      if (booking.status == BookingStatus.active && 
          booking.endDate.isBefore(now)) {
        booking.status = BookingStatus.completed;
        await booking.save();
      }
    }
  }

  List<BookingModel> getActiveCarBookings(String carId) {
    _updateExpiredBookings(); 
    return bookingBox.values
        .where((booking) => 
          booking.carId == carId && 
          booking.status == BookingStatus.active)
        .toList();
  }

  bool hasCompletedBookingForCar(String carId) {
    return bookingBox.values
        .any((booking) => 
          booking.carId == carId && 
          booking.status == BookingStatus.completed);
  }

  Future<void> updateExpiredBookings() async {
    await _updateExpiredBookings();
  }
}