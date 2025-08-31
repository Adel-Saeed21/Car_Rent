import 'package:carrent/feature/auth/forget_password/data/i_reset_password_repo.dart';
import 'package:carrent/feature/auth/forget_password/logic/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.resetPasswordRepo) : super(ResetPasswordInitial());
  final IResetPasswordRepo resetPasswordRepo;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailResetPasswordController = TextEditingController();



   Future<void> sendPasswordResetEmail() async {
    emit(ResetPasswordEmailLoading());
    
    try {
      final email = emailResetPasswordController.text.trim();
      await resetPasswordRepo.sendPasswordResetEmail(email);
      
      emit(ResetPasswordSuccess(
        message: 'If this email exists, we\'ve sent a password reset link'
      ));
    } catch (e) {
      emit(ResetPasswordError(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
        errorType: ResetPasswordErrorType.emailError,
      ));
    }
  }

  @override
  Future<void> close() {
    emailResetPasswordController.dispose();
    return super.close();
  }
}
