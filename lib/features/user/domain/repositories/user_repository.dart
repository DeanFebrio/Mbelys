import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  AsyncResult<void> createUser({required UserEntity user});
  AsyncResult<UserEntity> getUserProfile({required String uid});
}