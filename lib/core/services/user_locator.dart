import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/data/repositories/user_repository_impl.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';
import 'package:mbelys/features/user/domain/usecases/get_user_data_usecase.dart';
import 'package:mbelys/features/user/presentation/viewmodel/profile_viewmodel.dart';

Future <void> initUser () async {
  sl.registerLazySingleton<UserDataSource>(() => FirestoreUserDataSource());

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userDataSource: sl<UserDataSource>()
  ));

  sl.registerLazySingleton<GetUserDataUseCase>(() => GetUserDataUseCase(
      userRepository: sl<UserRepository>(),
      authRepository: sl<AuthRepository>()
  ));

  sl.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel(
      authViewmodel: sl<AuthViewModel>()
  ));
}