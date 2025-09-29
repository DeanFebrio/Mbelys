import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/device/domain/entities/device_entity.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';

class GetDeviceUseCase {
  final DeviceRepository repository;
  GetDeviceUseCase ({ required this.repository });

  AsyncResult<DeviceEntity> call ({ required String deviceId }) async {
    return await repository.getDevice(deviceId: deviceId);
  }
}