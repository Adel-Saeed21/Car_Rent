import 'package:equatable/equatable.dart';

 
class CarDetailsState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isLoading;
  final bool bookingSuccess;
  final String? error;

  const CarDetailsState({
    this.startDate,
    this.endDate,
    this.isLoading = false,
    this.bookingSuccess = false,
    this.error,
  });

  CarDetailsState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    bool? isLoading,
    bool? bookingSuccess,
    String? error,
     
    bool clearError = false, 
    bool clearSuccess = false,
  }) {
    return CarDetailsState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isLoading: isLoading ?? this.isLoading,
      bookingSuccess: clearSuccess ? false : (bookingSuccess ?? this.bookingSuccess),
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [startDate, endDate, isLoading, bookingSuccess, error];
}
