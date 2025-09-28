import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  AsyncResult<void> createUser({required UserEntity user});

  AsyncResult<UserEntity> getUserData ({ required String userId });
  Stream<UserEntity> watchUserData ({ required String userId });

  AsyncVoidResult changeUserName ({ required String userId, required String name });
  AsyncVoidResult changeUserPhoneNumber ({ required String userId, required String phoneNumber });
  AsyncVoidResult changeUserPhoto ({ required String userId, required File imageFile });
}