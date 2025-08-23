import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  Future<Either<Failure, UserEntity>> login (String email, String password);
  Future<Either<Failure, UserEntity>> register (String email, String password, String name, String phone);
  Future<Either<Failure, void>> logout();
}