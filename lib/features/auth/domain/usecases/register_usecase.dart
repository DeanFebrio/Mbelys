import 'package:dartz/dartz.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call(String email, String password, String name, String phone) async {
    return await repository.register(email, password, name, phone);
  }
}