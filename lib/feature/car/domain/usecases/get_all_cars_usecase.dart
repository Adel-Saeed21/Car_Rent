import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/car/domain/repositories/i_car_repository.dart';

 
class GetAllCarsUseCase {
  final ICarRepository _repository;

  GetAllCarsUseCase(this._repository);

  Future<List<CarEntity>> call() async {
    return await _repository.getAllCars();
  }
}
