import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/forgot_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/login_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/register_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/update_name_usecase.dart';
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

  sl.registerFactory<ForgotUseCase>(() => ForgotUseCase(
      authRepository: sl<AuthRepository>()
  ));

  sl.registerFactory<ChangePasswordUseCase>(() =>
      ChangePasswordUseCase(
          authRepository: sl<AuthRepository>()
      )
  );

  sl.registerFactory<UpdateNameUseCase>(() => UpdateNameUseCase(
      authRepository: sl<AuthRepository>()
  ));

  sl.registerFactory<LoginWithGoogleUseCase>(() => LoginWithGoogleUseCase(
      authRepository: sl<AuthRepository>(),
      userRepository: sl<UserRepository>()
  ));
}