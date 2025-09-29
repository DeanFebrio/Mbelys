import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';

class ReprovisionWifiUseCase {
  final DeviceRepository repository;
  ReprovisionWifiUseCase ({ required this.repository });

  AsyncVoidResult call ({ required String deviceId }) async {
    return await repository.reprovisionWifi(deviceId: deviceId);
  }
}