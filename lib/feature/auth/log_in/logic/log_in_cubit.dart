import 'package:carrent/feature/auth/log_in/logic/log_in_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInCubit extends Cubit<LoginState> {
  LogInCubit() : super(const LoginInitial());
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
}
