import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class WatchUserDataUseCase {
  final UserRepository userRepository;
  WatchUserDataUseCase({
    required this.userRepository,
  });

  Stream<UserEntity> call ({required String uid}) {
    return userRepository.watchUserData(uid: uid);
  }
}