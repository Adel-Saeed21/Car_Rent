import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/car/domain/repositories/i_car_repository.dart';

 
class GetCarByIdUseCase {
  final ICarRepository _repository;

  GetCarByIdUseCase(this._repository);

  Future<CarEntity?> call(String carId) async {
    return await _repository.getCarById(carId);
  }
}
