import 'package:dartz/dartz.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserData(String uid);
  Future<Either<Failure, void>> updateName(String name);
  Future<Either<Failure, void>> updatePhone(String phone);

  Future<Either<Failure, void>> requestUpdateEmail(String email);
  Future<Either<Failure, bool>> finalizeEmailChange();

  Future<Either<Failure, void>> updatePassword ({
    required String email,
    required String oldPassword,
    required String newPassword,
  });

  Future <Either<Failure, void>> deleteAccount(String email, String password);
}