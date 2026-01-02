import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/booking/domain/repositories/i_booking_repository.dart';
import 'package:carrent/feature/car/domain/repositories/i_car_repository.dart';

 
class GetBookedCarsUseCase {
  final IBookingRepository _bookingRepository;
  final ICarRepository _carRepository;

  GetBookedCarsUseCase(this._bookingRepository, this._carRepository);

   
  Future<List<CarEntity>> call(String userId) async {
     
    final completedBookings = await _bookingRepository.getCompletedBookings(userId);
    
     
    final carIds = completedBookings.map((booking) => booking.carId).toSet().toList();
    
     
    final List<CarEntity> cars = [];
    for (final carId in carIds) {
      final car = await _carRepository.getCarById(carId);
      if (car != null) {
        cars.add(car);
      }
    }
    
    return cars;
  }
}
