import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class ChangeNameUseCase {
  final UserRepository userRepository;

  ChangeNameUseCase ({
    required this.userRepository,
  });

  AsyncVoidResult call ({ required String userId, required String name }) async {
    return await userRepository.changeUserName(userId: userId, name: name);
  }
}