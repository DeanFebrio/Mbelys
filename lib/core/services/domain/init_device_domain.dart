import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';
import 'package:mbelys/features/device/domain/usecases/ensure_device_registered.dart';
import 'package:mbelys/features/device/domain/usecases/get_device_usecase.dart';
import 'package:mbelys/features/device/domain/usecases/is_device_exists_usecase.dart';
import 'package:mbelys/features/device/domain/usecases/register_device_usecase.dart';
import 'package:mbelys/features/device/domain/usecases/reprovision_wifi_usecase.dart';

Future<void> initDeviceDomain () async {
  sl.registerFactory<RegisterDeviceUseCase>(() => RegisterDeviceUseCase(
      repository: sl<DeviceRepository>()
  ));

  sl.registerFactory<GetDeviceUseCase>(() => GetDeviceUseCase(
      repository: sl<DeviceRepository>()
  ));

  sl.registerFactory<ReprovisionWifiUseCase>(() => ReprovisionWifiUseCase(
      repository: sl<DeviceRepository>()
  ));

  sl.registerFactory<IsDeviceExistsUseCase>(() => IsDeviceExistsUseCase(
      repository: sl<DeviceRepository>()
  ));

  sl.registerFactory<EnsureDeviceRegisteredUseCase>(() => EnsureDeviceRegisteredUseCase(
      repository: sl<DeviceRepository>()
  ));
}