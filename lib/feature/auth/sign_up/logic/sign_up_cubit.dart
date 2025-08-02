import 'package:bloc/bloc.dart';
import 'package:carrent/feature/auth/sign_up/logic/signup_state.dart';
import 'package:flutter/material.dart';

class SignUpCubit extends Cubit<SignupState> {
  SignUpCubit() : super(const SignupInitial());
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

}
