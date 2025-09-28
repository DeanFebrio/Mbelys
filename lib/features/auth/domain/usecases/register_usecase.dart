import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  RegisterUseCase ({ required this.authRepository, required this.userRepository });

  AsyncResult<UserEntity> call({
    required String email,
    required String password,
    required String name,
    required String phone
  }) async {
    try {
      final authResult = await authRepository.register(
        email: email,
        password: password,
        name: name,
      );

      return await authResult.fold(
        (failure) => errAsync<UserEntity>(failure),
        (auth) async {
          final userProfile = UserEntity(
              userId: auth.userId,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              email: email,
              name: name,
              phoneNumber: phone,
              userPhotoUrl: null
          );
          final profileResult = await userRepository.createUser(user: userProfile);

          return profileResult.fold(
            (failure) => errAsync<UserEntity>(failure),
            (_) => okAsync<UserEntity>(userProfile)
          );
        }
      );
    } catch (e) {
      return errAsync<UserEntity>(AuthFailure(e.toString()));
    }
  }
}