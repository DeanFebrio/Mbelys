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
    } catch (e) {
      throw Exception("Gagal membuat akun di Firestore");
    }
  }

  @override
  AsyncResult<UserEntity> getUserProfile({required String uid}) async {
    try {
      final result = await userDataSource.getUserProfile(uid: uid);
      return ok(result);
    } catch (e) {
      throw Exception("Gagal mengambil data pengguna dari Firestore");
    }
  }
  
}