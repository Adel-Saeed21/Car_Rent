import 'package:carrent/feature/auth/log_in/data/repos/i_login_repo.dart';
import 'package:carrent/feature/auth/log_in/logic/log_in_state.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class LogInCubit extends Cubit<LoginState> {
  LogInCubit(this.repo) : super(const LoginInitial());
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  final ILoginRepo repo;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(const LoginLoading());
    try {
      final userCred = await repo.login(
        email: loginEmail.text.trim(),
        password: loginPassword.text.trim(),
      );

      final box = Hive.box<UserData>('UserDataBox');
      final userData = UserData(
        uid: userCred.user?.uid,
        email: userCred.user?.email,
        name: userCred.user?.displayName,
        phone: userCred.user?.phoneNumber,
      );
      await box.put('currentUser', userData);
      emit(LoginSuccess(userCred));
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
    }
  }
}
