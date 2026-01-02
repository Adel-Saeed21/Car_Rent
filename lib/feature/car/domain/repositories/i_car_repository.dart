import 'package:carrent/feature/car/domain/entities/car_entity.dart';

 
abstract class ICarRepository {
   
  Future<List<CarEntity>> getAllCars();

   
  Future<List<CarEntity>> getCarsByBrand(String brand);

   
  Future<CarEntity?> getCarById(String carId);

   
  Future<List<String>> getAllBrands();
}
