import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';

class GetAuthStateUseCase {
  final AuthRepository authRepository;
  GetAuthStateUseCase({required this.authRepository});

  Stream<User?> call(){
    return authRepository.authStateChanges;
  }
}