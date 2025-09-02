import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';

class ForgotUseCase {
  final AuthRepository authRepository;

  ForgotUseCase({required this.authRepository});

  AsyncVoidResult call ({required String email}) async {
    return await authRepository.forgotPassword(email: email);
  }
}