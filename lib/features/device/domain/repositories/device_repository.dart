import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/device/domain/entities/device_entity.dart';

abstract class DeviceRepository {
  AsyncResult<String> registerDevice ();
  AsyncResult<DeviceEntity> getDevice ({ required String deviceId });
  AsyncVoidResult reprovisionWifi ({ required String deviceId });
  AsyncResult<bool> isDeviceExists ({ required String deviceId });
}