import 'package:carrent/core/utils/app_assets.dart';

class CarModel {
  final String id;
  final String name;
  final String brand;
  final String imageAsset;
  final int maxSpeed;
  final int seats;
  final String pricePerDay;
  final List<String> features;
  bool isFavorite;

  CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageAsset,
    required this.maxSpeed,
    required this.seats,
    required this.pricePerDay,
    required this.features,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  CarModel copyWith({
    String? id,
    String? name,
    String? brand,
    String? imageAsset,
    int? maxSpeed,
    int? seats,
    String? pricePerDay,
    List<String>? features,
    bool? isFavorite,
  }) {
    return CarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      imageAsset: imageAsset ?? this.imageAsset,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      seats: seats ?? this.seats,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      features: features ?? this.features,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// Cars Data organized by brand
final Map<String, List<CarModel>> carsData = {
  "Mercedes": [
    CarModel(
      id: "mercedes_1",
      name: "AMG GT",
      brand: "Mercedes",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 310,
      seats: 2,
      pricePerDay: "250/Day",
      features: ["Leather Seats", "Sport Mode", "Navigation", "Bluetooth"],
    ),
    CarModel(
      id: "mercedes_2",
      name: "S-Class",
      brand: "Mercedes",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 250,
      seats: 4,
      pricePerDay: "200/Day",
      features: ["Luxury Interior", "Massage Seats", "Panoramic Roof"],
    ),
    CarModel(
      id: "mercedes_3",
      name: "C-Class",
      brand: "Mercedes",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 240,
      seats: 4,
      pricePerDay: "150/Day",
      features: ["Sport Package", "LED Lights", "Apple CarPlay"],
    ),
  ],

  "BMW": [
    CarModel(
      id: "bmw_1",
      name: "M5",
      brand: "BMW",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 305,
      seats: 4,
      pricePerDay: "280/Day",
      features: ["M Performance", "Carbon Fiber", "Head-Up Display"],
    ),
    CarModel(
      id: "bmw_2",
      name: "X6",
      brand: "BMW",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 250,
      seats: 5,
      pricePerDay: "220/Day",
      features: ["All-Wheel Drive", "Sport Seats", "Premium Sound"],
    ),
    CarModel(
      id: "bmw_3",
      name: "i8",
      brand: "BMW",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 250,
      seats: 2,
      pricePerDay: "350/Day",
      features: ["Hybrid Engine", "Butterfly Doors", "Carbon Body"],
    ),
  ],

  "Audi": [
    CarModel(
      id: "audi_1",
      name: "R8",
      brand: "Audi",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 330,
      seats: 2,
      pricePerDay: "300/Day",
      features: ["V10 Engine", "Quattro AWD", "Virtual Cockpit"],
    ),
    CarModel(
      id: "audi_2",
      name: "Q7",
      brand: "Audi",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 240,
      seats: 7,
      pricePerDay: "180/Day",
      features: ["3rd Row Seats", "Matrix LED", "Bang & Olufsen"],
    ),
    CarModel(
      id: "audi_3",
      name: "A8",
      brand: "Audi",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 250,
      seats: 4,
      pricePerDay: "230/Day",
      features: ["Executive Package", "Massage Function", "Night Vision"],
    ),
  ],

  "Bentley": [
    CarModel(
      id: "bentley_1",
      name: "Continental GT",
      brand: "Bentley",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 333,
      seats: 4,
      pricePerDay: "450/Day",
      features: ["W12 Engine", "Diamond Quilting", "Rotating Display"],
    ),
    CarModel(
      id: "bentley_2",
      name: "Mulsanne",
      brand: "Bentley",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 296,
      seats: 4,
      pricePerDay: "400/Day",
      features: ["Handcrafted Interior", "Mulliner Spec", "Privacy Glass"],
    ),
  ],

  "Lamborghini": [
    CarModel(
      id: "lambo_1",
      name: "Huracán",
      brand: "Lamborghini",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 325,
      seats: 2,
      pricePerDay: "500/Day",
      features: ["V10 Engine", "Carbon Fiber", "Track Mode"],
    ),
    CarModel(
      id: "lambo_2",
      name: "Aventador",
      brand: "Lamborghini",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 350,
      seats: 2,
      pricePerDay: "600/Day",
      features: ["Scissor Doors", "V12 Engine", "Launch Control"],
    ),
  ],

  "Ferrari": [
    CarModel(
      id: "ferrari_1",
      name: "488 GTB",
      brand: "Ferrari",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 330,
      seats: 2,
      pricePerDay: "550/Day",
      features: ["Twin Turbo V8", "F1 Technology", "Side Slip Control"],
    ),
    CarModel(
      id: "ferrari_2",
      name: "F8 Tributo",
      brand: "Ferrari",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 340,
      seats: 2,
      pricePerDay: "580/Day",
      features: ["720 HP", "Aerodynamic Body", "Racing Suspension"],
    ),
  ],
};

List<CarModel> getCarsByBrand(String brand) {
  return carsData[brand] ?? [];
}

List<CarModel> getAllCars() {
  return carsData.values.expand((cars) => cars).toList();
}

List<CarModel> getFavoriteCars() {
  return getAllCars().where((car) => car.isFavorite).toList();
}
