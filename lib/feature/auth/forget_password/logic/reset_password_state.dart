abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordEmailLoading extends ResetPasswordState {}





class ResetPasswordChanging extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final String message;

  ResetPasswordSuccess({required this.message});
}

class ResetPasswordError extends ResetPasswordState {
  final String errorMessage;
  final ResetPasswordErrorType errorType;

  ResetPasswordError({required this.errorMessage, required this.errorType});
}

enum ResetPasswordErrorType { emailError, otpError, passwordError }
