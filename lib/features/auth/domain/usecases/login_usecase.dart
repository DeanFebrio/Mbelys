import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  AsyncResult<AuthEntity> call(String email, String password) {
    return authRepository.login(email: email, password: password);
  }
}