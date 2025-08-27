import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mbelys/core/services/auth_locator.dart';
import 'package:mbelys/core/services/home_locator.dart';
import 'package:mbelys/core/services/user_locator.dart';

final sl = GetIt.instance;

Future<void> setupLocator () async {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  await initAuth();
  await initUser();
  await initHome();
}