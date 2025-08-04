import 'package:bloc/bloc.dart';
import 'package:carrent/feature/auth/sign_up/logic/signup_state.dart';
import 'package:carrent/feature/auth/sign_up/repo/i_sign_up_repo.dart';
import 'package:flutter/material.dart';

class SignUpCubit extends Cubit<SignupState> {
  SignUpCubit(this.repo) : super(const SignupInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
  }

  final ISignUpRepo repo;
  Future<void> signUp() async {
    emit(const SignupLoading());
    try {
      repo.signUp(email:emailController.text, password: passwordController.text, name: nameController.text, phone: phoneController.text);
    } catch (e) {
      emit(SignupError(errorMessage: e.toString()));
    }
  }
}
