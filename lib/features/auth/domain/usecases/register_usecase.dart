import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  RegisterUseCase({
    required this.authRepository,
    required this.userRepository
  });

  AsyncResult<UserEntity> call(String email, String password, String name, String phone) async {

    try {
      final authResult = await authRepository.register(
        email: email,
        password: password,
        name: name,
      );

      final authEntity = authResult.getOrNull();

      final userProfile = UserEntity(
          uid: authEntity!.uid,
          email: email,
          name: name,
          phone: phone,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()
      );

      final profileResult = await userRepository.createUser(user: userProfile);
      profileResult.getOrNull();
      return ok(userProfile);
    } catch (e) {
      return err(AuthFailure(e.toString()));
    }
  }
}