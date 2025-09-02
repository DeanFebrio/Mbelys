import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/error/firestore_error_mapper.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/data/models/user_model.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.userDataSource});
  final UserDataSource userDataSource;

  @override
  AsyncResult<void> createUser({required UserEntity user}) async {
    try {
      final userModel = UserModel(
        uid: user.uid,
        email: user.email,
        name: user.name,
        phone: user.phone,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      );
      final result = await userDataSource.createUser(user: userModel);
      return ok(result);
    } on FirebaseException catch (e) {
      return err(mapFirestoreError(e));
    } catch (e) {
      return err(AuthFailure("Gagal membuat akun di Firestore"));
    }
  }

  @override
  AsyncResult<UserEntity> getUserData ({required String uid}) async {
    try {
      final result = await userDataSource.getUserData(uid: uid);
      return ok(result);
    } on FirebaseException catch (e) {
      return err(mapFirestoreError(e));
    } catch (e) {
      return err(AuthFailure("Gagal mengambil data pengguna dari Firestore"));
    }
  }

  @override
  Stream<UserEntity> watchUserData ({required String uid}) {
    try {
      final result = userDataSource.watchUserData(uid: uid);
      return result;
    } on FirebaseException catch (e) {
      return Stream.error(mapFirestoreError(e));
    } catch (e) {
      return Stream.error(AuthFailure("Gagal mengambil data pengguna dari Firestore"));
    }
  }

  @override
  AsyncVoidResult changeName ({required String name, required String uid}) async {
    try {
      await userDataSource.changeName(name: name, uid: uid);
      return okUnit();
    } on FirebaseException catch (e) {
      return err(mapFirestoreError(e));
    } catch (e) {
      return err(AuthFailure("Gagal melakukan perubahan nama"));
    }
  }

  @override
  AsyncVoidResult changePhone ({required String phone, required String uid}) async {
    try {
      await userDataSource.changePhone(phone: phone, uid: uid);
      return okUnit();
    } on FirebaseException catch (e) {
      return err(mapFirestoreError(e));
    } catch (e) {
      return err(AuthFailure("Gagal melakukan perubahan nomor telepon"));
    }
  }
}