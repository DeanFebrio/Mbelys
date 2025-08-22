import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/data/data_source/auth_datasource.dart';
import 'package:mbelys/data/repositories/auth_repository_impl.dart';
import 'package:mbelys/domain/repositories/auth_repository.dart';
import 'package:mbelys/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/domain/usecases/get_user_data_usecase.dart';
import 'package:mbelys/domain/usecases/login_usecase.dart';
import 'package:mbelys/domain/usecases/logout_usecase.dart';
import 'package:mbelys/domain/usecases/register_usecase.dart';
import 'package:mbelys/presentation/auth/viewmodel/auth_viewmodel.dart';
import 'package:mbelys/presentation/auth/viewmodel/login_viewmodel.dart';
import 'package:mbelys/presentation/auth/viewmodel/register_viewmodel.dart';
import 'package:mbelys/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:mbelys/presentation/profile/viewmodel/profile_viewmodel.dart';


Future<void> initAuth () async {
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource());

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authDataSource: sl<AuthDataSource>()
  ));

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(
      repository: sl<AuthRepository>()
  ));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(
      repository: sl<AuthRepository>()
  ));
  
  sl.registerLazySingleton<GetUserDataUseCase> (
      () => GetUserDataUseCase(authRepository: sl<AuthRepository>())
  );

  sl.registerLazySingleton<GetAuthStateUseCase> (
      () => GetAuthStateUseCase(authRepository: sl<AuthRepository>())
  );

  sl.registerLazySingleton<LogoutUseCase> (
      () => LogoutUseCase(authRepository: sl<AuthRepository>())
  );

  sl.registerFactory<RegisterViewModel>(() => RegisterViewModel(
      registerUseCase: sl<RegisterUseCase>()
  ));

  sl.registerFactory<LoginViewModel>(() => LoginViewModel(
      loginUseCase: sl<LoginUseCase>()
  ));

  sl.registerFactory<AuthViewmodel> (() => AuthViewmodel(
      getUserDataUseCase: sl<GetUserDataUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getAuthStateUseCase: sl<GetAuthStateUseCase>()
  ));

  sl.registerFactory<ProfileViewModel> (
          () => ProfileViewModel(authViewmodel: sl<AuthViewmodel>())
  );

  sl.registerFactory<HomeViewModel> (
      () => HomeViewModel(authViewmodel: sl<AuthViewmodel>())
  );
}