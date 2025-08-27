abstract class Failure implements Exception {
  final String message;
  final String? code;
  final Object? cause;
  final StackTrace? stackTrace;

  const Failure (
      this.message, {
        this.code,
        this.cause,
        this.stackTrace
  });

  @override
  String toString() => code == null ? message : '$message: ($code)';
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {String? code, Object? cause, StackTrace? stackTrace})
  : super (message, code: code, cause: cause, stackTrace: stackTrace);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message, {String? code, Object? cause, StackTrace? stackTrace})
      : super (message, code: code, cause: cause, stackTrace: stackTrace);
}

class AuthFailure extends Failure {
  const AuthFailure(String message, {String? code, Object? cause, StackTrace? stackTrace})
      : super (message, code: code, cause: cause, stackTrace: stackTrace);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message, {String? code})
      : super (message, code: code);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(String message, {String? code})
      : super (message, code: code);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message, {String? code, Object? cause, StackTrace? stackTrace})
      : super (message, code: code, cause: cause, stackTrace: stackTrace);
}