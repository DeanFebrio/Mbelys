import 'package:mbelys/features/device/domain/repositories/device_repository.dart';

class EnsureDeviceRegisteredUseCase {
  final DeviceRepository repository;
  const EnsureDeviceRegisteredUseCase({ required this.repository });

  Future<void> call ({ required String deviceId }) async {
    await repository.ensureDeviceRegistered(deviceId: deviceId);
  }
}