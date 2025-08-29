import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/login_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/register_usecase.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/register_viewmodel.dart';

Future<void> initAuthPresentation () async {
  sl.registerLazySingleton<AuthViewModel>(() => AuthViewModel(
      getAuthState: sl<GetAuthStateUseCase>(),
      logoutUseCase: sl<LogoutUseCase>()
  ));

  sl.registerFactory<LoginViewModel>(() => LoginViewModel(
      loginUseCase: sl<LoginUseCase>()
  ));

  sl.registerFactory<RegisterViewModel>(() => RegisterViewModel(
      registerUseCase: sl<RegisterUseCase>()
  ));
}