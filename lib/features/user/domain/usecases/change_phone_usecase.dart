import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class ChangePhoneUseCase {
  final UserRepository userRepository;

  ChangePhoneUseCase ({
    required this.userRepository,
  });

  AsyncVoidResult call ({required String phone, required String uid}) async {
    return await userRepository.changePhone(phone: phone, uid: uid);
  }
}