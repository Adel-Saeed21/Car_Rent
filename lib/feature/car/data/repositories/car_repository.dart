import 'package:carrent/feature/car/data/datasources/car_local_data_source.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/feature/car/domain/repositories/i_car_repository.dart';

 
class CarRepository implements ICarRepository {
  final CarLocalDataSource _localDataSource;

  CarRepository(this._localDataSource);

  @override
  Future<List<CarEntity>> getAllCars() async {
    final cars = _localDataSource.getAllCars();
    return cars.map((car) => car.toEntity()).toList();
  }

  @override
  Future<List<CarEntity>> getCarsByBrand(String brand) async {
    final cars = _localDataSource.getCarsByBrand(brand);
    return cars.map((car) => car.toEntity()).toList();
  }

  @override
  Future<CarEntity?> getCarById(String carId) async {
    final car = _localDataSource.getCarById(carId);
    return car?.toEntity();
  }

  @override
  Future<List<String>> getAllBrands() async {
    return _localDataSource.getAllBrands();
  }
}
