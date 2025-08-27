import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';

class GetAuthStateUseCase {
  final AuthRepository authRepository;
  GetAuthStateUseCase({required this.authRepository});

  Stream<AuthEntity?> call(){
    return authRepository.authStatusChanges;
  }
}