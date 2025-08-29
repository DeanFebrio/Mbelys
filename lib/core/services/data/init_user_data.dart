import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/data/repositories/user_repository_impl.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

Future<void> initUserData () async {
  sl.registerLazySingleton<UserDataSource>(() => FirestoreUserDataSource(
      firestore: sl<FirebaseFirestore>()
  ));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userDataSource: sl<UserDataSource>()
  ));
}