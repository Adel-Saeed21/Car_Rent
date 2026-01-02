import 'package:carrent/feature/car/domain/entities/car_entity.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

 
class SpecificationDataModel {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  SpecificationDataModel({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

   
  SpecificationData toEntity() {
    return SpecificationData(
      title: title,
      value: value,
      iconName: _iconToString(icon),
      iconColor: _colorToString(iconColor),
    );
  }

   
  factory SpecificationDataModel.fromEntity(SpecificationData entity) {
    return SpecificationDataModel(
      icon: _stringToIcon(entity.iconName),
      iconColor: _stringToColor(entity.iconColor),
      title: entity.title,
      value: entity.value,
    );
  }

  static String _iconToString(IconData icon) {
    return icon.codePoint.toString();
  }

  static IconData _stringToIcon(String iconString) {
    try {
      final codePoint = int.parse(iconString);
      return IconData(codePoint, fontFamily: 'MaterialIcons');
    } catch (e) {
      return MdiIcons.car;
    }
  }

  static String _colorToString(Color color) {
    return color.value.toString();
  }

  static Color _stringToColor(String colorString) {
    try {
      final value = int.parse(colorString);
      return Color(value);
    } catch (e) {
      return Colors.blue;
    }
  }
}

 
class CarModel {
  final String id;
  final String name;
  final String brand;
  final String imageAsset;
  final int maxSpeed;
  final int seats;
  final double pricePerDay;
  final List<String> features;
  final List<SpecificationDataModel>? carDataSpecification;

  CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageAsset,
    required this.maxSpeed,
    required this.seats,
    required this.pricePerDay,
    required this.features,
    this.carDataSpecification,
  });

   
  CarEntity toEntity() {
    return CarEntity(
      id: id,
      name: name,
      brand: brand,
      imageAsset: imageAsset,
      maxSpeed: maxSpeed,
      seats: seats,
      pricePerDay: pricePerDay,
      features: features,
      carDataSpecification: carDataSpecification?.map((spec) => spec.toEntity()).toList(),
    );
  }

   
  factory CarModel.fromEntity(CarEntity entity) {
    return CarModel(
      id: entity.id,
      name: entity.name,
      brand: entity.brand,
      imageAsset: entity.imageAsset,
      maxSpeed: entity.maxSpeed,
      seats: entity.seats,
      pricePerDay: entity.pricePerDay,
      features: entity.features,
      carDataSpecification: entity.carDataSpecification?.map((spec) => SpecificationDataModel.fromEntity(spec)).toList(),
    );
  }
}
