import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:mbelys/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/domain/usecases/get_user_data_usecase.dart';
import 'package:mbelys/features/user/presentation/viewmodel/profile_viewmodel.dart';

Future<void> initAuth () async {
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource(
    firebaseAuth: sl<FirebaseAuth>()
  ));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authDataSource: sl<AuthDataSource>(),
      userDataSource: sl<UserDataSource>()
  ));

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(
      repository: sl<AuthRepository>()
  ));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(
      repository: sl<AuthRepository>()
  ));


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

  sl.registerFactory<AuthViewModel> (() => AuthViewModel(
      getUserDataUseCase: sl<GetUserDataUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getAuthStateUseCase: sl<GetAuthStateUseCase>()
  ));

  sl.registerFactory<ProfileViewModel> (
          () => ProfileViewModel(authViewmodel: sl<AuthViewModel>())
  );

  sl.registerFactory<HomeViewModel> (
      () => HomeViewModel(authViewmodel: sl<AuthViewModel>())
  );
}