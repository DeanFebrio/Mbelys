import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:mbelys/core/services/data/init_auth_data.dart';
import 'package:mbelys/core/services/data/init_user_data.dart';
import 'package:mbelys/core/services/domain/init_auth_domain.dart';
import 'package:mbelys/core/services/domain/init_user_domain.dart';
import 'package:mbelys/core/services/home_locator.dart';
import 'package:mbelys/core/services/presentation/init_auth_presentation.dart';
import 'package:mbelys/core/services/presentation/init_user_presentation.dart';
import 'package:mbelys/firebase_options.dart';

final sl = GetIt.instance;

Future<void> setupLocator () async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final rc = FirebaseRemoteConfig.instance;
  await rc.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(seconds: 0),
  ));
  await rc.fetchAndActivate();

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseRemoteConfig>(() => FirebaseRemoteConfig.instance);

  // data layer
  await initAuthData();
  await initUserData();

  // domain layer
  await initAuthDomain();
  await initUserDomain();

  // presentation layer
  initAuthPresentation();
  initUserPresentation();

  await initHome();
}