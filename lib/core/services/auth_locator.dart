import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/data/datasources/auth_datasource.dart';
import 'package:mbelys/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/login_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/register_usecase.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/register_viewmodel.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';
import 'package:mbelys/features/user/domain/usecases/get_user_data_usecase.dart';

Future<void> initAuth () async {
  sl.registerLazySingleton<AuthDataSource>(() => FirebaseAuthDataSource());

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authDataSource: sl<AuthDataSource>()
  ));

  sl.registerLazySingleton<GetAuthStateUseCase>(() => GetAuthStateUseCase(
      authRepository: sl<AuthRepository>()
  ));

  sl.registerLazySingleton<RegisterUseCase>(() =>
      RegisterUseCase(
          authRepository: sl<AuthRepository>(),
          userRepository: sl<UserRepository>()
      )
  );

  sl.registerLazySingleton<LoginUseCase>(() =>
      LoginUseCase(
          authRepository: sl<AuthRepository>(),
      )
  );

  sl.registerLazySingleton<LogoutUseCase>(() =>
      LogoutUseCase(
          authRepository: sl<AuthRepository>(),
      )
  );

  sl.registerFactory<RegisterViewModel>(() => RegisterViewModel(
      registerUseCase: sl<RegisterUseCase>()
  ));

  sl.registerFactory<LoginViewModel>(() => LoginViewModel(
      loginUseCase: sl<LoginUseCase>()
  ));

  sl.registerFactory<AuthViewModel>(() => AuthViewModel(
      getAuthState: sl<GetAuthStateUseCase>(),
      getUserData: sl<GetUserDataUseCase>(),
      logoutUseCase: sl<LogoutUseCase>()
  ));

}