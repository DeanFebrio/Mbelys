import 'package:dartz/dartz.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  const UserRepositoryImpl({required this.userDataSource});

  @override
  Future<Either<Failure, void>> deleteAccount(String email, String password) async {
    try {
      await userDataSource.deleteAccount(
          email: email,
          password: password
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> finalizeEmailChange() async {
    try {
      final result = await userDataSource.finalizeEmailChange();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(String uid) async {
    try {
      final result = await userDataSource.getUserData(uid);
      if (result == null) return Left(ServerFailure('User tidak ditemukan'));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> requestUpdateEmail(String email) async {
    try {
      final result = await userDataSource.requestUpdateEmail(email);
      return Right(result);
    } catch (e){
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateName(String name) async {
    try {
      final result = await userDataSource.updateName(name);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword({
      required String email,
      required String oldPassword,
      required String newPassword
    }) async {
    try {
      final result = await userDataSource.updatePassword(
          email: email,
          oldPassword: oldPassword,
          newPassword: newPassword
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePhone(String phone) async {
    try {
      final result = await userDataSource.updatePhone(phone);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}