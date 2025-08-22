import 'package:dartz/dartz.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase({required this.authRepository});

  Future<Either<Failure, void>> call () async {
    return await authRepository.logout();
  }
}