import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
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

  @override
  List<Object?> get props => [message, code, cause];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class UserFailure extends Failure {
  const UserFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class FileSystemFailure extends Failure {
  const FileSystemFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class ConfigurationFailure extends Failure {
  const ConfigurationFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class OperationFailure extends Failure {
  const OperationFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class DataParsingFailure extends Failure {
  const DataParsingFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class StorageFailure extends Failure {
  const StorageFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class ResourceExhaustedFailure extends Failure {
  const ResourceExhaustedFailure(super.message, {super.code, super.cause, super.stackTrace});
}

class FeatureNotAvailableFailure extends Failure {
  const FeatureNotAvailableFailure(super.message, {super.code, super.cause, super.stackTrace});
}