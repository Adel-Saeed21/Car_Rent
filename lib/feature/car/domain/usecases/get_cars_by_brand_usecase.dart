import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/car/domain/repositories/i_car_repository.dart';

 
class GetCarsByBrandUseCase {
  final ICarRepository _repository;

  GetCarsByBrandUseCase(this._repository);

  Future<List<CarEntity>> call(String brand) async {
    return await _repository.getCarsByBrand(brand);
  }
}
