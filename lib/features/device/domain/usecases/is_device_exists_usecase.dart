import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';

class IsDeviceExistsUseCase {
  final DeviceRepository repository;
  IsDeviceExistsUseCase ({ required this.repository });

  AsyncResult<bool> call ({ required String deviceId }) async {
    return await repository.isDeviceExists(deviceId: deviceId);
  }
}