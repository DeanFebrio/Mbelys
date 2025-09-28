import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/error/firestore_error_mapper.dart';
import 'package:mbelys/core/utils/logger.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/data/models/user_model.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.userDataSource});
  final UserDataSource userDataSource;

  @override
  AsyncResult<void> createUser({ required UserEntity user }) async {
    try {
      final userModel = UserModel(
        userId: user.userId,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
        email: user.email,
        name: user.name,
        phoneNumber: user.phoneNumber,
        userPhotoUrl: null
      );
      await userDataSource.createUser(user: userModel);
      logInfoLazy(() => "✅ Successfully created user: ${user.name}");
      return okVoidAsync();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in createUser", error: e, stackTrace: stackTrace);
      return errAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in createGoatShed", error: e, stackTrace: stackTrace);
      return errAsync(DatabaseFailure("Gagal membuat akun di Firestore"));
    }
  }

  @override
  AsyncResult<UserEntity> getUserData ({ required String userId }) async {
    try {
      final result = await userDataSource.getUserData(userId: userId);
      logInfoLazy(() => "✅ Successfully get user data: ${result.name}");
      return okAsync(result);
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in getUserData", error: e, stackTrace: stackTrace);
      return errAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in getUserData", error: e, stackTrace: stackTrace);
      return errAsync(DatabaseFailure("Gagal mengambil data pengguna dari Firestore"));
    }
  }

  @override
  Stream<UserEntity> watchUserData ({ required String userId }) {
    try {
      final result = userDataSource.watchUserData(userId: userId);
      return result;
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in watchUserData", error: e, stackTrace: stackTrace);
      return Stream.error(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in watchUserData", error: e, stackTrace: stackTrace);
      return Stream.error(UserFailure("Gagal mengambil data pengguna dari Firestore"));
    }
  }

  @override
  AsyncVoidResult changeUserName ({ required String userId, required String name }) async {
    try {
      await userDataSource.updateUserData(userId: userId, updates: {"name": name});
      logInfoLazy(() => "✅ Successfully changed name: $name");
      return okVoidAsync();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in changeName", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in changeName", error: e, stackTrace: stackTrace);
      return errVoidAsync(UserFailure("Gagal melakukan perubahan nama"));
    }
  }

  @override
  AsyncVoidResult changeUserPhoneNumber ({ required String userId, required String phoneNumber }) async {
    try {
      await userDataSource.updateUserData(userId: userId, updates: {"phoneNumber": phoneNumber});
      logInfoLazy(() => "✅ Successfully changed phone: $phoneNumber");
      return okVoidAsync();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in changePhone", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in changePhone", error: e, stackTrace: stackTrace);
      return errVoidAsync(UserFailure("Gagal melakukan perubahan nomor telepon"));
    }
  }

  @override
  AsyncVoidResult changeUserPhoto ({ required String userId, required File imageFile }) async {
    try {
      await userDataSource.changeUserPhoto(userId: userId, imageFile: imageFile);
      logInfoLazy(() => "✅ Successfully changed photo: ${imageFile.path}");
      return okVoidAsync();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in changePhoto", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in changePhoto", error: e, stackTrace: stackTrace);
      return errVoidAsync(UserFailure("Gagal melakukan perubahan foto profil"));
    }
  }
}