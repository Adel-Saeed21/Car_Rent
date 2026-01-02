import 'package:equatable/equatable.dart';

 
class SpecificationData extends Equatable {
  final String title;
  final String value;
  final String iconName;
  final String iconColor;

  const SpecificationData({
    required this.title,
    required this.value,
    required this.iconName,
    required this.iconColor,
  });

  @override
  List<Object?> get props => [title, value, iconName, iconColor];
}

 
class CarEntity extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String imageAsset;
  final int maxSpeed;
  final int seats;
  final double pricePerDay;
  final List<String> features;
  final List<SpecificationData>? carDataSpecification;

  const CarEntity({
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

  CarEntity copyWith({
    String? id,
    String? name,
    String? brand,
    String? imageAsset,
    int? maxSpeed,
    int? seats,
    double? pricePerDay,
    List<String>? features,
    List<SpecificationData>? carDataSpecification,
  }) {
    return CarEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      imageAsset: imageAsset ?? this.imageAsset,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      seats: seats ?? this.seats,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      features: features ?? this.features,
      carDataSpecification: carDataSpecification ?? this.carDataSpecification,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        imageAsset,
        maxSpeed,
        seats,
        pricePerDay,
        features,
        carDataSpecification,
      ];
}
