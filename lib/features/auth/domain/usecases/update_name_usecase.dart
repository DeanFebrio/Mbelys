import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';

class UpdateNameUseCase {
  final AuthRepository authRepository;

  UpdateNameUseCase({required this.authRepository});

  AsyncVoidResult call ({ required String name }) async {
    return await authRepository.updateName(name: name);
  }
}