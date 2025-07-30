abstract class SignupState<T> {
  const SignupState();

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String error) error,
  });

  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
    required R Function() orElse,
  });

  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
  });
}


// ---------------------------- Initial ----------------------------

class SignupInitial<T> extends SignupState<T> {
  const SignupInitial();

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String error) error,
  }) {
    return initial();
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
    required R Function() orElse,
  }) {
    return initial != null ? initial() : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  String toString() => 'SignupState.initial()';

  @override
  bool operator ==(Object other) => other is SignupInitial<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// ---------------------------- Loading ----------------------------

class SignupLoading<T> extends SignupState<T> {
  const SignupLoading();

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String error) error,
  }) {
    return loading();
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
    required R Function() orElse,
  }) {
    return loading != null ? loading() : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  String toString() => 'SignupState.loading()';

  @override
  bool operator ==(Object other) => other is SignupLoading<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// ---------------------------- Success ----------------------------

class SignupSuccess<T> extends SignupState<T> {
  final T data;

  const SignupSuccess(this.data);

  SignupSuccess<T> copyWith({T? data}) {
    return SignupSuccess<T>(data ?? this.data);
  }

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String error) error,
  }) {
    return success(data);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
    required R Function() orElse,
  }) {
    return success != null ? success(data) : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
  }) {
    return success?.call(data);
  }

  @override
  String toString() => 'SignupState.success(data: $data)';

  @override
  bool operator ==(Object other) =>
      other is SignupSuccess<T> && other.data == data;

  @override
  int get hashCode => data.hashCode ^ runtimeType.hashCode;
}

// ---------------------------- Error ----------------------------

class SignupError<T> extends SignupState<T> {
  final String errorMessage;

  const SignupError({required this.errorMessage});

  SignupError<T> copyWith({String? errorMessage}) {
    return SignupError<T>(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String error) error,
  }) {
    return error(errorMessage);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
    required R Function() orElse,
  }) {
    return error != null ? error(errorMessage) : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
  }) {
    return error?.call(errorMessage);
  }

  @override
  String toString() => 'SignupState.error(error: $errorMessage)';

  @override
  bool operator ==(Object other) =>
      other is SignupError<T> && other.errorMessage == errorMessage;

  @override
  int get hashCode => errorMessage.hashCode ^ runtimeType.hashCode;
}
