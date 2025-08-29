import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class GetUserDataUseCase {
  final UserRepository userRepository;
  GetUserDataUseCase({
    required this.userRepository,
  });

  AsyncResult<UserEntity> call (String uid) async {
    return await userRepository.getUserData(uid: uid);
  }
}