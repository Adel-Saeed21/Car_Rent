class CarDetailsState {
  final DateTime? startDate;
  final DateTime? endDate;
  final double? price;
  final String? error;
  final bool bookingSuccess;
  final bool isLoading;
  
  const CarDetailsState({
    this.startDate, 
    this.endDate, 
    this.price,
    this.error,
    this.bookingSuccess = false,
    this.isLoading = false,
  });

  CarDetailsState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    double? price,
    String? error,
    bool? bookingSuccess,
    bool? isLoading,
  }) {
    return CarDetailsState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      error: error,
      bookingSuccess: bookingSuccess ?? this.bookingSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}