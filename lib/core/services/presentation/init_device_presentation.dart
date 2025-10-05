import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/device/domain/usecases/ensure_device_registered.dart';
import 'package:mbelys/features/device/domain/usecases/is_device_exists_usecase.dart';
import 'package:mbelys/features/device/domain/usecases/register_device_usecase.dart';
import 'package:mbelys/features/device/presentation/viewmodels/provision_viewmodel.dart';

Future<void> initDevicePresentation () async {
  sl.registerFactory<ProvisionViewModel>(() => ProvisionViewModel(
    registerDeviceUseCase: sl<RegisterDeviceUseCase>(),
    ensureDeviceRegisteredUseCase: sl<EnsureDeviceRegisteredUseCase>(),
    isDeviceExistsUseCase: sl<IsDeviceExistsUseCase>()
  ));
}