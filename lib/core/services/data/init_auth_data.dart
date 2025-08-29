import 'package:firebase_auth/firebase_auth.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/data/datasources/auth_datasource.dart';
import 'package:mbelys/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mbelys/features/auth/domain/repositories/auth_repository.dart';


Future<void> initAuthData () async {
  sl.registerLazySingleton<AuthDataSource>(() => FirebaseAuthDataSource(
    firebaseAuth: sl<FirebaseAuth>()
  ));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authDataSource: sl<AuthDataSource>()
  ));
}