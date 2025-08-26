class CarDetailsState {
  final DateTime? startDate;
  final DateTime? endDate;
  final double? price;

  const CarDetailsState({this.startDate, this.endDate, this.price});

  CarDetailsState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    double? price,
  }) {
    return CarDetailsState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
    );
  }
}
