import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/data/data_source/auth_datasource.dart';
import 'package:mbelys/data/repositories/auth_repository_impl.dart';
import 'package:mbelys/domain/repositories/auth_repository.dart';
import 'package:mbelys/domain/usecases/login_usecase.dart';
import 'package:mbelys/domain/usecases/register_usecase.dart';
import 'package:mbelys/presentation/auth/viewmodel/login_viewmodel.dart';
import 'package:mbelys/presentation/auth/viewmodel/register_viewmodel.dart';


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

  sl.registerFactory<RegisterViewModel>(() => RegisterViewModel(
      registerUseCase: sl<RegisterUseCase>()
  ));

  sl.registerFactory<LoginViewModel>(() => LoginViewModel(
      loginUseCase: sl<LoginUseCase>()
  ));
}