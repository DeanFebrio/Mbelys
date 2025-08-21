import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/data/data_source/auth_datasource.dart';
import 'package:mbelys/domain/entities/user_entity.dart';
import 'package:mbelys/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  String mapAuthError (FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'Email atau password salah';
      case 'wrong-password':
        return 'Password salah';
      case 'user-not-found':
        return 'Akun tidak ditemukan';
      case 'email-already-in-use':
        return "Email telah terdaftar";
      case 'invalid-email':
        return 'Format email tidak valid';
      default:
        return 'Terjadi kesalahan: ${e.message ?? 'Tidak diketahui'}';
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login (String email, String password) async {
    try {
      final userModel = await authDataSource.signIn(email: email, password: password);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left (ServerFailure(mapAuthError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(String email, String password, String name, String phone) async {
    try {
      final userModel = await authDataSource.signUp(email: email, password: password, name: name, phone: phone);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(mapAuthError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}