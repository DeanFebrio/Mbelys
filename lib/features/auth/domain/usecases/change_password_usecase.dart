import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUseCase {
  final AuthRepository authRepository;

  ChangePasswordUseCase({required this.authRepository});

  AsyncVoidResult call({required String oldPassword, required String newPassword }) async {
    return await authRepository.changePassword(oldPassword: oldPassword, newPassword: newPassword);
  }
}