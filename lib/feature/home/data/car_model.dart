import 'package:carrent/core/utils/app_assets.dart';
import 'package:carrent/feature/car_Details/widgets/specification_car_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CarModel {
  final String id;
  final String name;
  final String brand;
  final String imageAsset;
  final int maxSpeed;
  final int seats;
  final String pricePerDay;
  final List<String> features;
  final List<SpecificationData>? carDataSpecification;
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
    this.carDataSpecification,
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
      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "310 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "2.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "2 Seats",
        ),
      ],
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
      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "250 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-200 km/h",
          value: "3.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "4 Seats",
        ),
      ],
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
      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "240 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "3.5 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "4 Seats",
        ),
      ],
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
      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "305 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "2.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "4 Seats",
        ),
      ],
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
      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "250 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.8 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "5 Seats",
        ),
      ],
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

      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "250 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "2 Seats",
        ),
      ],
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

      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "330 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "2.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "2 Seats",
        ),
      ],
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

      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "240 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "3.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "7 Seats",
        ),
      ],
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

      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "250 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "3.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "4 Seats",
        ),
      ],
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

      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "333 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "4 Seats",
        ),
      ],
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
      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "296 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "2.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "4 Seats",
        ),
      ],
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
      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "325 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "2 Seats",
        ),
      ],
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

      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "350 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "3.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "2 Seats",
        ),
      ],
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

      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "330 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "2 Seats",
        ),
      ],
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

      carDataSpecification: [
        SpecificationData(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "340 km/h",
        ),
        SpecificationData(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationData(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationData(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "2 Seats",
        ),
      ],
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
