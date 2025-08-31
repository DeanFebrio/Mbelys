import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  AsyncResult<void> createUser({required UserEntity user});

  AsyncResult<UserEntity> getUserData ({ required String uid });
  Stream<UserEntity> watchUserData ({required String uid});

  AsyncVoidResult changeName ({required String name, required String uid});
  AsyncVoidResult changePhone ({required String phone, required String uid});

  AsyncVoidResult markEmailChangePending ({ required String pendingEmail, required String uid });
  AsyncVoidResult commitEmailChange ({ required String authEmail, required String uid });
  AsyncVoidResult clearEmailChangePending ({ required String uid });
}