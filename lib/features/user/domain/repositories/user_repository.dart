import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  AsyncResult<void> createUser({required UserEntity user});

  AsyncResult<UserEntity> getUserData ({ required String uid });
  Stream<UserEntity> watchUserData ({required String uid});

  AsyncVoidResult changeName ({required String name, required String uid});
  AsyncVoidResult changePhone ({required String phone, required String uid});
  AsyncVoidResult changePhoto ({ required File file, required String uid });
}