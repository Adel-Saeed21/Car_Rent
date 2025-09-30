import 'package:carrent/feature/FeedBack/Logic/feedback_cubit.dart';
import 'package:carrent/feature/FeedBack/data/Repos/feedback_repo.dart';
import 'package:carrent/feature/FeedBack/data/Repos/i_feedback_repo.dart';
import 'package:carrent/feature/auth/forget_password/data/i_reset_password_repo.dart';
import 'package:carrent/feature/auth/forget_password/data/reset_password_repo.dart';
import 'package:carrent/feature/auth/forget_password/logic/reset_password_cubit.dart';
import 'package:carrent/feature/auth/log_in/data/repos/i_login_repo.dart';
import 'package:carrent/feature/auth/log_in/data/repos/login_repo_implementation.dart';
import 'package:carrent/feature/auth/log_in/logic/log_in_cubit.dart';
import 'package:carrent/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carrent/feature/auth/sign_up/repo/i_sign_up_repo.dart';
import 'package:carrent/feature/auth/sign_up/repo/sign_up_repo_implementation.dart';
import 'package:carrent/feature/favourite_items/data/repo/favourite_repo_imp.dart';
import 'package:carrent/feature/favourite_items/data/repo/i_favourite_repo.dart';
import 'package:carrent/feature/favourite_items/logic/favourite_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;

Future<void> setUpDI() async {

  // log in cubit
  getit.registerFactory(() => LogInCubit(getit()));
  getit.registerLazySingleton<ILoginRepo>(
    () => LoginRepoImplementation(FirebaseAuth.instance),
  );
  getit.registerLazySingleton<ISignUpRepo>(() => SignUpRepoImplementation());
  getit.registerFactory(() => SignUpCubit(getit()));

  getit.registerSingletonAsync<IFeedbackRepository>(() async {
    final repo = FeedbackRepository();
    await repo.init();
    return repo;
  });

  await getit.isReady<IFeedbackRepository>();

  getit.registerFactory<FeedbackCubit>(() {
    final repo = getit.get<IFeedbackRepository>();
    return FeedbackCubit(repo);
  });


  //reset password cubit and repo
  getit.registerLazySingleton<IResetPasswordRepo>(() => ResetPasswordRepo());
  getit.registerFactory(() => ResetPasswordCubit(getit<IResetPasswordRepo>()));

   getit.registerLazySingleton<IFavouriteRepo>(
    () => FavouriteRepository(),
  );
  
  // Register Cubit Factory
  getit.registerFactory<FavouriteCubit>(
    () => FavouriteCubit(getit<FavouriteRepository>()),
  );
}
