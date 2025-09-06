import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/goat_shed/data/datasources/goat_shed_datasource.dart';
import 'package:mbelys/features/goat_shed/data/repositories/goat_shed_repository_impl.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

Future<void> initGoatShedData () async {
  sl.registerLazySingleton<GoatShedDataSource>(() => FirestoreGoatShedDataSource(
      firestore: sl<FirebaseFirestore>()
  ));

  sl.registerLazySingleton<GoatShedRepository>(() => GoatShedRepositoryImpl(
      goatShedDataSource: sl<GoatShedDataSource>()
  ));
}