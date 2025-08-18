abstract class LoginState<T> {
  const LoginState();

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

class LoginInitial<T> extends LoginState<T> {
  const LoginInitial();

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
  String toString() => 'LoginState.initial()';

  @override
  bool operator ==(Object other) => other is LoginInitial<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// ---------------------------- Loading ----------------------------

class LoginLoading<T> extends LoginState<T> {
  const LoginLoading();

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
  String toString() => 'LoginState.loading()';

  @override
  bool operator ==(Object other) => other is LoginLoading<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// ---------------------------- Success ----------------------------

class LoginSuccess<T> extends LoginState<T> {
  final T data;

  const LoginSuccess(this.data);

  LoginSuccess<T> copyWith({T? data}) {
    return LoginSuccess<T>(data ?? this.data);
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
  String toString() => 'LoginState.success(data: $data)';

  @override
  bool operator ==(Object other) =>
      other is LoginSuccess<T> && other.data == data;

  @override
  int get hashCode => data.hashCode ^ runtimeType.hashCode;
}

// ---------------------------- Error ----------------------------

class LoginError<T> extends LoginState<T> {
  final String errorMessage;

  const LoginError({required this.errorMessage});

  LoginError<T> copyWith({String? errorMessage}) {
    return LoginError<T>(errorMessage: errorMessage ?? this.errorMessage);
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
  String toString() => 'LoginState.error(error: $errorMessage)';

  @override
  bool operator ==(Object other) =>
      other is LoginError<T> && other.errorMessage == errorMessage;

  @override
  int get hashCode => errorMessage.hashCode ^ runtimeType.hashCode;
}
