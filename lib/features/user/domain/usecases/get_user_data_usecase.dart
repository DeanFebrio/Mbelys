import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class GetUserDataUseCase {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  GetUserDataUseCase({
    required this.userRepository,
    required this.authRepository
  });

  AsyncResult<UserEntity> call (String uid) async {
    return await userRepository.getUserProfile(uid: uid);
  }
}