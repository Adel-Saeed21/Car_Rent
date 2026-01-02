import 'package:carrent/feature/booking/data/datasources/booking_local_data_source.dart';
import 'package:carrent/feature/car/data/datasources/car_local_data_source.dart';
import 'package:carrent/feature/favorite/data/datasources/favorite_local_data_source.dart';
import 'package:carrent/feature/feedback/data/datasources/feedback_local_data_source.dart';
import 'package:carrent/feature/booking/data/repositories/booking_repository.dart';
import 'package:carrent/feature/car/data/repositories/car_repository.dart';
import 'package:carrent/feature/favorite/data/repositories/favorite_repository.dart';
import 'package:carrent/feature/feedback/data/repositories/feedback_repository.dart';
import 'package:carrent/feature/booking/domain/repositories/i_booking_repository.dart';
import 'package:carrent/feature/car/domain/repositories/i_car_repository.dart';
import 'package:carrent/feature/favorite/domain/repositories/i_favorite_repository.dart';
import 'package:carrent/feature/feedback/domain/repositories/i_feedback_repository.dart';
import 'package:carrent/feature/car/domain/usecases/get_all_cars_usecase.dart';
import 'package:carrent/feature/car/domain/usecases/get_car_by_id_usecase.dart';
import 'package:carrent/feature/car/domain/usecases/get_cars_by_brand_usecase.dart';
import 'package:carrent/feature/favorite/domain/usecases/add_favorite_usecase.dart';
import 'package:carrent/feature/favorite/domain/usecases/get_favorites_usecase.dart';
import 'package:carrent/feature/favorite/domain/usecases/is_favorite_usecase.dart';
import 'package:carrent/feature/favorite/domain/usecases/remove_favorite_usecase.dart';
import 'package:carrent/feature/feedback/domain/usecases/add_feedback_usecase.dart';
import 'package:carrent/feature/feedback/domain/usecases/get_booked_cars_usecase.dart';
import 'package:carrent/feature/feedback/domain/usecases/get_car_feedbacks_usecase.dart';
import 'package:carrent/feature/feedback/domain/usecases/update_feedback_usecase.dart';
import 'package:carrent/feature/auth/forget_password/data/i_reset_password_repo.dart';
import 'package:carrent/feature/auth/forget_password/data/reset_password_repo.dart';
import 'package:carrent/feature/auth/forget_password/logic/reset_password_cubit.dart';
import 'package:carrent/feature/auth/log_in/data/repos/i_login_repo.dart';
import 'package:carrent/feature/auth/log_in/data/repos/login_repo_implementation.dart';
import 'package:carrent/feature/auth/log_in/logic/log_in_cubit.dart';
import 'package:carrent/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carrent/feature/auth/sign_up/repo/i_sign_up_repo.dart';
import 'package:carrent/feature/auth/sign_up/repo/sign_up_repo_implementation.dart';
import 'package:carrent/feature/car_details/presentation/cubit/car_details_cubit.dart';
import 'package:carrent/feature/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:carrent/feature/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;

Future<void> setUpDI() async {
   
  getit.registerFactory(() => LogInCubit(getit()));
  getit.registerLazySingleton<ILoginRepo>(
    () => LoginRepoImplementation(FirebaseAuth.instance),
  );
  getit.registerLazySingleton<ISignUpRepo>(() => SignUpRepoImplementation());
  getit.registerFactory(() => SignUpCubit(getit()));
  
  getit.registerLazySingleton<IResetPasswordRepo>(() => ResetPasswordRepo());
  getit.registerFactory(() => ResetPasswordCubit(getit<IResetPasswordRepo>()));

   
   
   

   
  getit.registerLazySingleton(() => CarLocalDataSource());
  getit.registerLazySingleton(() => FavoriteLocalDataSource());
  getit.registerLazySingleton(() => BookingLocalDataSource());
  getit.registerLazySingleton(() => FeedbackLocalDataSource());

   
  getit.registerLazySingleton<ICarRepository>(
    () => CarRepository(getit()),
  );
  getit.registerLazySingleton<IFavoriteRepository>(
    () => FavoriteRepository(getit(), getit()),
  );
  getit.registerLazySingleton<IBookingRepository>(
    () => BookingRepository(getit()),
  );
  getit.registerLazySingleton<IFeedbackRepository>(
    () => FeedbackRepository(getit()),
  );

   
   
  getit.registerLazySingleton(() => GetAllCarsUseCase(getit()));
  getit.registerLazySingleton(() => GetCarsByBrandUseCase(getit()));
  getit.registerLazySingleton(() => GetCarByIdUseCase(getit()));
  
   
  getit.registerLazySingleton(() => GetFavoritesUseCase(getit()));
  getit.registerLazySingleton(() => AddFavoriteUseCase(getit()));
  getit.registerLazySingleton(() => RemoveFavoriteUseCase(getit()));
  getit.registerLazySingleton(() => IsFavoriteUseCase(getit()));

   
  getit.registerLazySingleton(() => AddFeedbackUseCase(getit()));
  getit.registerLazySingleton(() => UpdateFeedbackUseCase(getit()));
  getit.registerLazySingleton(() => GetCarFeedbacksUseCase(getit()));
  getit.registerLazySingleton(() => GetBookedCarsUseCase(getit(), getit()));

   
  getit.registerFactory(() => FavoriteCubit(getit(), getit(), getit(), getit()));
  getit.registerFactory(() => FeedbackCubit(getit(), getit(), getit(), getit()));
  
   
  getit.registerFactoryParam<CarDetailsCubit, double, String>(
    (price, carId) => CarDetailsCubit(
      bookingRepository: getit(),
      pricePerDay: price,
      carId: carId,
    ),
  );
}
