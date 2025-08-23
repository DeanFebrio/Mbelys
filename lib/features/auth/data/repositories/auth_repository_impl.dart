import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/data/datasources/auth_datasource.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final UserDataSource userDataSource;

  const AuthRepositoryImpl({
    required this.authDataSource,
    required this.userDataSource,
  });

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
      final user = await authDataSource.signIn(email: email, password: password);
      final model = await userDataSource.getUserData(user.uid);
      if (model != null) {
        return Right(model);
      } else {
        return Left(ServerFailure('User tidak ditemukan di database'));
      }
    } on FirebaseAuthException catch (e) {
      return Left (ServerFailure(mapAuthError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      String email,
      String password,
      String name,
      String phone
    ) async {
    try {
      final user = await authDataSource.signUp(
          email: email,
          password: password,
          name: name
      );
      final model = await userDataSource.syncOnRegister(
          uid: user.uid,
          email: email,
          name: name,
          phone: phone
      );
      return Right(model);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(mapAuthError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<User?> get authStateChanges => authDataSource.authStateChanges;

  @override
  Future<Either<Failure, void>> logout () async {
    try {
      await authDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}