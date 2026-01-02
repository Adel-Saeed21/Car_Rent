import 'package:carrent/feature/car/data/models/car_model.dart';
import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:carrent/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



 
final Map<String, List<CarModel>> carsData = {
  "Mercedes": [
    CarModel(
      id: "mercedes_1",
      name: "AMG GT",
      brand: "Mercedes",
      imageAsset: Assets.assetsImagesCar1,
      maxSpeed: 310,
      seats: 2,
      pricePerDay: 250,
      features: ["Leather Seats", "Sport Mode", "Navigation", "Bluetooth"],
      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "310 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "2.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 200,
      features: ["Luxury Interior", "Massage Seats", "Panoramic Roof"],
      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "250 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-200 km/h",
          value: "3.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 150,
      features: ["Sport Package", "LED Lights", "Apple CarPlay"],
      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "240 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "3.5 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 280,
      features: ["M Performance", "Carbon Fiber", "Head-Up Display"],
      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "305 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "2.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 220,
      features: ["All-Wheel Drive", "Sport Seats", "Premium Sound"],
      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "250 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.8 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 350,
      features: ["Hybrid Engine", "Butterfly Doors", "Carbon Body"],

      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "250 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 300,
      features: ["V10 Engine", "Quattro AWD", "Virtual Cockpit"],

      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "330 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "2.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 180,
      features: ["3rd Row Seats", "Matrix LED", "Bang & Olufsen"],

      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "240 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "3.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 230,
      features: ["Executive Package", "Massage Function", "Night Vision"],

      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "250 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "3.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 450,
      features: ["W12 Engine", "Diamond Quilting", "Rotating Display"],

      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "333 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 400,
      features: ["Handcrafted Interior", "Mulliner Spec", "Privacy Glass"],
      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "296 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "2.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 500,
      features: ["V10 Engine", "Carbon Fiber", "Track Mode"],
      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "325 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 600,
      features: ["Scissor Doors", "V12 Engine", "Launch Control"],

      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "350 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "3.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 550,
      features: ["Twin Turbo V8", "F1 Technology", "Side Slip Control"],

      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "330 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationDataModel(
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
      pricePerDay: 580,
      features: ["720 HP", "Aerodynamic Body", "Racing Suspension"],

      carDataSpecification: [
        SpecificationDataModel(
          icon: MdiIcons.speedometer,
          iconColor: Colors.cyan,
          title: "Top Speed",
          value: "340 km/h",
        ),
        SpecificationDataModel(
          icon: MdiIcons.battery,
          iconColor: Colors.green,
          title: "Range",
          value: "520 km",
        ),
        SpecificationDataModel(
          icon: MdiIcons.rocketLaunch,
          iconColor: Colors.orange,
          title: "0-100 km/h",
          value: "1.2 sec",
        ),
        SpecificationDataModel(
          icon: MdiIcons.seatReclineNormal,
          iconColor: Colors.blue,
          title: "Seats",
          value: "2 Seats",
        ),
      ],
    ),
  ],
};

List<CarEntity> getCarsByBrand(String brand) {
  final cars = carsData[brand] ?? [];
  return cars.map((e) => e.toEntity()).toList();
}

List<CarEntity> getAllCars() {
  final allCars = carsData.values.expand((cars) => cars).toList();
  return allCars.map((e) => e.toEntity()).toList();
}

List<CarEntity> getFavoriteCars() {
   
   
   
   
   
   
   
   
  return [];
}
