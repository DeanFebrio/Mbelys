import 'package:dartz/dartz.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}