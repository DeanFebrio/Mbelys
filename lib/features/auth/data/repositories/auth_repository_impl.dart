import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/error/auth_error_mapper.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/logger.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/data/datasources/auth_datasource.dart';
import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  const AuthRepositoryImpl ({ required this.authDataSource });

  AuthEntity mapUserToEntity ({ required User user }) {
    return AuthEntity(
        userId: user.uid,
        email: user.email ?? ""
    );
  }

  @override
  Stream<AuthEntity?> get authStatusChanges {
    return authDataSource.authStateChanges.map((user) {
      return user != null ? mapUserToEntity(user: user) : null;
    });
  }

  @override
  AuthEntity? get currentUser {
    final user = authDataSource.currentUser;
    return user != null ? mapUserToEntity(user: user) : null;
  }

  @override
  AsyncResult<AuthEntity> register ({ required String email, required String password, required String name }) async {
    try {
      final user = await authDataSource.signUp(email: email, password: password, name: name);
      logInfoLazy(() => "✅ Successfully created user in auth: ${user.uid}");
      return ok(mapUserToEntity(user: user));
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in register", error: e, stackTrace: stackTrace);
      return err(mapFirebaseAuthError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in register", error: e, stackTrace: stackTrace);
      return err(UserFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncResult<AuthEntity> login ({ required String email, required String password }) async {
    try {
      final user = await authDataSource.signIn(email: email, password: password);
      logInfoLazy(() => "✅ Successfully logged in user in auth: ${user.uid}");
      return ok(mapUserToEntity(user: user));
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in login", error: e, stackTrace: stackTrace);
      return err(mapFirebaseAuthError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in login", error: e, stackTrace: stackTrace);
      return err(UserFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncVoidResult logout () async {
    try {
      await authDataSource.signOut();
      logInfoLazy(() => "✅ Successfully logged out user in auth: ${authDataSource.currentUser?.uid}");
      return okVoidAsync();
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in logout", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirebaseAuthError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in logout", error: e, stackTrace: stackTrace);
      return errVoidAsync(UserFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncVoidResult changePassword ({ required String oldPassword, required String newPassword }) async {
    try {
      await authDataSource.changePassword(oldPassword: oldPassword, newPassword: newPassword);
      logInfoLazy(() => "✅ Successfully changed password");
      return okVoidAsync();
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in changePassword", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirebaseAuthError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in changePassword", error: e, stackTrace: stackTrace);
      return errVoidAsync(UserFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncVoidResult forgotPassword ({ required String email }) async {
    try {
      await authDataSource.forgotPassword(email: email);
      logInfoLazy(() => "✅ Successfully sent password reset email: $email");
      return okVoidAsync();
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in forgotPassword", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirebaseAuthError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in forgotPassword", error: e, stackTrace: stackTrace);
      return errVoidAsync(UserFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncVoidResult updateName ({ required String name }) async {
    try {
      await authDataSource.updateName(name: name);
      logInfoLazy(() => "✅ Successfully updated name: $name");
      return okVoidAsync();
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in updateName", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirebaseAuthError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in updateName", error: e, stackTrace: stackTrace);
      return errVoidAsync(UserFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncVoidResult reloadUser () async {
    try {
      await authDataSource.reloadUser();
      logInfoLazy(() => "✅ Successfully reloaded user: ${authDataSource.currentUser?.uid}");
      return okVoidAsync();
    } on FirebaseAuthException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in reloadUser", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirebaseAuthError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in reloadUser", error: e, stackTrace: stackTrace);
      return errVoidAsync(UserFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncResult<UserEntity> signInWithFacebook () {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  AsyncResult<UserEntity> signInWithGoogle () {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

}