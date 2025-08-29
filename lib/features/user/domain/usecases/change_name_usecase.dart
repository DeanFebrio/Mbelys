import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class ChangeNameUseCase {
  final UserRepository userRepository;

  ChangeNameUseCase ({
    required this.userRepository,
  });

  AsyncVoidResult call ({required String name, required String uid}) async {
    return await userRepository.changeName(name: name, uid: uid);
  }
}