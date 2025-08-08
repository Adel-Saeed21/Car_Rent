import 'package:carrent/feature/auth/log_in/data/repos/i_login_repo.dart';
import 'package:carrent/feature/auth/log_in/logic/log_in_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      emit(LoginSuccess(userCred));
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
    }
  }
}
