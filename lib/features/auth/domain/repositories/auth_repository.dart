import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<AuthEntity?> get authStatusChanges;
  AuthEntity? get currentUser;

  AsyncResult<AuthEntity> register ({
    required String email,
    required String password,
    required String name,
  });

  AsyncResult<AuthEntity> login ({
    required String email,
    required String password
  });

  AsyncVoidResult logout ();

  AsyncVoidResult changePassword({
    required String oldPassword,
    required String newPassword,
  });

  AsyncVoidResult forgotPassword({required String email});

  AsyncVoidResult changeEmail({required String newEmail});
  AsyncVoidResult reloadUser();

  AsyncResult<UserEntity> signInWithGoogle();
  AsyncResult<UserEntity> signInWithFacebook();
}