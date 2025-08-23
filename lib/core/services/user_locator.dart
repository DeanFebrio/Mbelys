import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/data/repositories/user_repository_impl.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';
import 'package:mbelys/features/user/domain/usecases/get_user_data_usecase.dart';

Future <void> initUser () async {
  sl.registerLazySingleton<UserDataSource>(() => UserDataSource(
      firestore: sl<FirebaseFirestore>(),
      auth: sl<FirebaseAuth>()
  ));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userDataSource: sl<UserDataSource>()
  ));

  sl.registerFactory<GetUserDataUseCase>(() => GetUserDataUseCase(
      repository: sl<UserRepository>()
  ));
}