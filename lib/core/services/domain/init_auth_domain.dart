import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/login_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/register_usecase.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

Future<void> initAuthDomain () async {
  sl.registerFactory<GetAuthStateUseCase>(() => GetAuthStateUseCase(
      authRepository: sl<AuthRepository>()
  ));

  sl.registerFactory<RegisterUseCase>(() =>
      RegisterUseCase(
          authRepository: sl<AuthRepository>(),
          userRepository: sl<UserRepository>()
      )
  );

  sl.registerFactory<LoginUseCase>(() =>
      LoginUseCase(
        authRepository: sl<AuthRepository>(),
      )
  );

  sl.registerFactory<LogoutUseCase>(() =>
      LogoutUseCase(
        authRepository: sl<AuthRepository>(),
      )
  );
}