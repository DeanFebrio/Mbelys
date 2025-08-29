import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/error/auth_error_mapper.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/data/datasources/auth_datasource.dart';
import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  const AuthRepositoryImpl ({ required this.authDataSource });

  AuthEntity _mapUserToEntity(User user) {
    return AuthEntity(
        uid: user.uid,
        email: user.email ?? ""
    );
  }

  @override
  Stream<AuthEntity?> get authStatusChanges {
    return authDataSource.authStateChanges.map((user) {
      return user != null ? _mapUserToEntity(user) : null;
    });
  }

  @override
  AsyncVoidResult changeEmail({required String newEmail}) async {
    try {
      await authDataSource.changeEmail(newEmail);
      return okUnit();
    } on FirebaseAuthException catch (e) {
      return err(mapFirebaseAuthError(e));
    } catch (e) {
      rethrow;
    }
  }

  @override
  AsyncVoidResult changePassword({required String oldPassword, required String newPassword}) async {
    try {
      await authDataSource.changePassword(oldPassword, newPassword);
      return okUnit();
    } on FirebaseAuthException catch (e) {
      return err(mapFirebaseAuthError(e));
    } catch (e) {
      rethrow;
    }
  }

  @override
  AuthEntity? get currentUser {
    final user = authDataSource.currentUser;
    return user != null ? _mapUserToEntity(user) : null;
  }

  @override
  AsyncVoidResult reloadUser() async {
    try {
      await authDataSource.reloadUser();
      return okUnit();
    } on FirebaseAuthException catch (e) {
      return err(mapFirebaseAuthError(e));
    } catch (e) {
      rethrow;
    }
  }

  @override
  AsyncVoidResult forgotPassword({required String email}) async {
    try {
      await authDataSource.forgotPassword(email);
      return okUnit();
    } on FirebaseAuthException catch (e) {
      return err(mapFirebaseAuthError(e));
    } catch (e) {
      rethrow;
    }
  }

  @override
  AsyncResult<AuthEntity> login({required String email, required String password}) async {
    try {
      final user = await authDataSource.signIn(email, password);
      return ok(_mapUserToEntity(user));
    } on FirebaseAuthException catch (e) {
      return err(mapFirebaseAuthError(e));
    } catch (e) {
      rethrow;
    }
  }

  @override
  AsyncVoidResult logout() async {
    try {
      await authDataSource.signOut();
      return okUnit();
    } on FirebaseAuthException catch (e) {
      return err(mapFirebaseAuthError(e));
    }  catch (e) {
      rethrow;
    }
  }

  @override
  AsyncResult<AuthEntity> register({required String email, required String password, required String name}) async {
    try {
      final user = await authDataSource.signUp(email, password, name);
      return ok(_mapUserToEntity(user));
    } on FirebaseAuthException catch (e) {
      return err(mapFirebaseAuthError(e));
    } catch (e) {
      rethrow;
    }
  }

  @override
  AsyncResult<UserEntity> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  AsyncResult<UserEntity> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

}