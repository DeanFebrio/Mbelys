import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/device/data/datasources/device_datasource.dart';
import 'package:mbelys/features/device/data/repositories/device_repository_impl.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';

Future<void> initDeviceData () async {
  sl.registerLazySingleton<DeviceDataSource>(() => FirestoreDeviceDataSource(
      firestore: sl<FirebaseFirestore>()
  ));

  sl.registerLazySingleton<DeviceRepository>(() => DeviceRepositoryImpl(
      dataSource: sl<DeviceDataSource>()
  ));
}