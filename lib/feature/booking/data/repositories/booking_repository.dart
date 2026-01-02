import 'package:carrent/feature/booking/data/datasources/booking_local_data_source.dart';
import 'package:carrent/feature/booking/data/models/booking_model.dart';
import 'package:carrent/feature/booking/domain/entities/booking_entity.dart';
import 'package:carrent/feature/booking/domain/repositories/i_booking_repository.dart';

 
class BookingRepository implements IBookingRepository {
  final BookingLocalDataSource _localDataSource;

  BookingRepository(this._localDataSource);

  @override
  Future<void> createBooking(BookingEntity booking) async {
    final bookingModel = BookingModel.fromEntity(booking);
    await _localDataSource.saveBooking(bookingModel);
  }

  @override
  Future<List<BookingEntity>> getUserBookings(String userId) async {
    final bookings = await _localDataSource.getBookingsByUserId(userId);
    return bookings.map((b) => b.toEntity()).toList();
  }

  @override
  Future<BookingEntity?> getBookingById(String bookingId) async {
    final booking = await _localDataSource.getBookingById(bookingId);
    return booking?.toEntity();
  }

  @override
  Future<List<BookingEntity>> getCarBookings(String carId) async {
    final bookings = await _localDataSource.getBookingsByCarId(carId);
    return bookings.map((b) => b.toEntity()).toList();
  }

  @override
  Future<void> updateBookingStatus(String bookingId, BookingStatus status) async {
    final booking = await _localDataSource.getBookingById(bookingId);
    if (booking == null) return;

    final updatedBooking = BookingModel(
      id: booking.id,
      carId: booking.carId,
      userId: booking.userId,
      startDate: booking.startDate,
      endDate: booking.endDate,
      bookingTime: booking.bookingTime,
      status: _statusFromEntity(status),
    );

    await _localDataSource.updateBooking(updatedBooking);
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await updateBookingStatus(bookingId, BookingStatus.cancelled);
  }

  @override
  Future<List<BookingEntity>> getActiveBookings(String userId) async {
    final bookings = await getUserBookings(userId);
    return bookings.where((b) => b.status == BookingStatus.active).toList();
  }

  @override
  Future<List<BookingEntity>> getCompletedBookings(String userId) async {
    final bookings = await getUserBookings(userId);
    return bookings.where((b) => b.status == BookingStatus.completed).toList();
  }

  @override
  Future<void> updateExpiredBookings() async {
    final allBookings = await _localDataSource.getAllBookings();
    final now = DateTime.now();

    for (final booking in allBookings) {
      if (booking.status == BookingStatusModel.active && now.isAfter(booking.endDate)) {
        final updatedBooking = BookingModel(
          id: booking.id,
          carId: booking.carId,
          userId: booking.userId,
          startDate: booking.startDate,
          endDate: booking.endDate,
          bookingTime: booking.bookingTime,
          status: BookingStatusModel.completed,
        );
        await _localDataSource.updateBooking(updatedBooking);
      }
    }
  }

  @override
  Future<void> deleteBooking(String bookingId) async {
    await _localDataSource.deleteBooking(bookingId);
  }

  BookingStatusModel _statusFromEntity(BookingStatus status) {
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
