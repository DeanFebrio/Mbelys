import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/launcher/data/datasources/launcher_datasource.dart';
import 'package:mbelys/features/launcher/data/repositories/launcher_repository_impl.dart';
import 'package:mbelys/features/launcher/domain/repositories/launcher_repostitory.dart';
import 'package:mbelys/features/user/data/datasources/user_datasource.dart';
import 'package:mbelys/features/user/data/repositories/user_repository_impl.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

Future<void> initUserData () async {
  sl.registerLazySingleton<UserDataSource>(() => FirestoreUserDataSource(
      firestore: sl<FirebaseFirestore>(),
      storage: sl<FirebaseStorage>()
  ));

  sl.registerLazySingleton<LauncherDataSource>(() => LauncherDataSource(
    remoteConfig: sl<FirebaseRemoteConfig>()
  ));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userDataSource: sl<UserDataSource>()
  ));

  sl.registerLazySingleton<LauncherRepository>(() => LauncherRepositoryImpl(
      launcherDataSource: sl<LauncherDataSource>()
  ));
}