import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';

class RegisterDeviceUseCase {
  final DeviceRepository repository;
  RegisterDeviceUseCase ({ required this.repository });

  AsyncResult<String> call () async {
    return await repository.registerDevice();
  }
}