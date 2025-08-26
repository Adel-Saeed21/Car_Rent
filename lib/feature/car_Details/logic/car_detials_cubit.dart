import 'package:carrent/feature/car_Details/logic/car_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
  CarDetailsCubit(this.dailyPrice) : super(const CarDetailsState());
final double dailyPrice;
  void selectStartDate(DateTime date) {
    DateTime? newEndDate = state.endDate;
    if (newEndDate != null && newEndDate.isBefore(date)) {
      newEndDate = null;
    }

    emit(state.copyWith(startDate: date, endDate: newEndDate));
  }

  void selectEndDate(DateTime date) {
    emit(state.copyWith(endDate: date));
  }

  int? getRentalDays() {
    if (state.startDate != null && state.endDate != null) {
      return state.endDate!.difference(state.startDate!).inDays + 1;
    }
    return null;
  }

  double getCarPrice() {
    if (state.startDate != null &&
        state.endDate != null ) {
      return dailyPrice * (state.endDate!.difference(state.startDate!).inDays +
          1);
    } else {
      return 0;
    }
  }
}
