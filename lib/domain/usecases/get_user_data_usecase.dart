import 'package:dartz/dartz.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/domain/entities/user_entity.dart';
import 'package:mbelys/domain/repositories/auth_repository.dart';

class GetUserDataUseCase {
  final AuthRepository authRepository;
  GetUserDataUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call (String uid) async {
    return await authRepository.getUserData(uid);
  }
}