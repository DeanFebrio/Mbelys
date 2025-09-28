import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase ({ required this.authRepository });

  AsyncVoidResult call () async {
    return await authRepository.logout();
  }
}