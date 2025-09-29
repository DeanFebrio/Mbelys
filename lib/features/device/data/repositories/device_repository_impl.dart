import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/error/firestore_error_mapper.dart';
import 'package:mbelys/core/utils/logger.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/device/data/datasources/device_datasource.dart';
import 'package:mbelys/features/device/domain/entities/device_entity.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceDataSource dataSource;
  DeviceRepositoryImpl ({ required this.dataSource });

  @override
  AsyncResult<String> registerDevice () async {
    try {
      final deviceId = await dataSource.registerDevice();
      logInfoLazy(() => "✅ Successfully registeredDevice: $deviceId");
      return okAsync(deviceId);
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in registerDevice", error: e, stackTrace: stackTrace);
      return errAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in registerDevice", error: e, stackTrace: stackTrace);
      return errAsync(DatabaseFailure("Gagal mendaftarkan perangkat baru"));
    }
  }

  @override
  AsyncResult<DeviceEntity> getDevice ({ required String deviceId }) async {
    try {
      final device = await dataSource.getDevice(deviceId: deviceId);
      logInfoLazy(() => "✅ Successfully getDevice: ${device.deviceId}");
      return okAsync(device);
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in getDevice", error: e, stackTrace: stackTrace);
      return errAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in getDevice", error: e, stackTrace: stackTrace);
      return errAsync(DatabaseFailure("Gagal mengambil data perangkat"));
    }
  }

  @override
  AsyncVoidResult reprovisionWifi ({ required String deviceId }) async {
    try {
      await dataSource.reprovisionWifi(deviceId: deviceId);
      logInfoLazy(() => "✅ Successfully reprovisionWifi: $deviceId");
      return okVoidAsync();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in reprovisionWifi", error: e, stackTrace: stackTrace);
      return errVoidAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in reprovisionWifi", error: e, stackTrace: stackTrace);
      return errVoidAsync(DatabaseFailure("Gagal reprovision wifi"));
    }
  }

  @override
  AsyncResult<bool> isDeviceExists ({ required String deviceId }) async {
    try {
      final result = await dataSource.isDeviceExists(deviceId: deviceId);
      logInfoLazy(() => "✅ Successfully isDeviceExists: $deviceId");
      return okAsync(result);
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in isDeviceExists", error: e, stackTrace: stackTrace);
      return errAsync(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in isDeviceExists", error: e, stackTrace: stackTrace);
      return errAsync(DatabaseFailure("Gagal memeriksa perangkat"));
    }
  }
}