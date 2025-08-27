import 'package:dartz/dartz.dart';
import 'package:mbelys/core/error/failure.dart';

typedef Result<T> = Either<Failure, T>;
typedef AsyncResult<T> = Future<Result<T>>;

Result<T> ok<T>(T value) => Right(value);
Result<Unit> okUnit() => const Right(unit);
Result<T> err<T>(Failure failure) => Left(failure);

typedef VoidResult = Result<Unit>;
typedef AsyncVoidResult = Future<VoidResult>;

extension ResultX<T> on Result<T> {
  T? getOrNull() => fold((_) => null, (r) => r);
  Failure? failureOrNull() => fold((l) => l, (_) => null);
}