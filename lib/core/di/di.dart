import 'package:carrent/feature/FeedBack/Logic/feedback_cubit.dart';
import 'package:carrent/feature/FeedBack/data/Repos/feedback_repo.dart';
import 'package:carrent/feature/FeedBack/data/Repos/i_feedback_repo.dart';
import 'package:carrent/feature/auth/log_in/data/repos/i_login_repo.dart';
import 'package:carrent/feature/auth/log_in/data/repos/login_repo_implementation.dart';
import 'package:carrent/feature/auth/log_in/logic/log_in_cubit.dart';
import 'package:carrent/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carrent/feature/auth/sign_up/repo/i_sign_up_repo.dart';
import 'package:carrent/feature/auth/sign_up/repo/sign_up_repo_implementation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;
void setUpDI() {
  //log in cubit
  getit.registerFactory(() => LogInCubit(getit()));
  getit.registerLazySingleton<ILoginRepo>(
    () => LoginRepoImplementation(FirebaseAuth.instance),
  );
  //signup  cubit
  getit.registerLazySingleton<ISignUpRepo>(() => SignUpRepoImplementation());
  getit.registerFactory(() => SignUpCubit(getit()));

  //feedback cubit
  getit.registerLazySingleton<IFeedbackRepository>(() => FeedbackRepository());
  getit.registerFactory(() => FeedbackCubit(getit()));
}
