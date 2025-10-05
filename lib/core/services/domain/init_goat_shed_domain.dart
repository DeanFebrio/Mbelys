import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_image_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_location_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_name_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_total_goats_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/create_goat_shed_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_detail_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_list_usecase.dart';

Future<void> initGoatShedDomain () async {
  sl.registerFactory<CreateGoatShedUseCase>(() => CreateGoatShedUseCase(
      goatShedRepository: sl<GoatShedRepository>(),
      deviceRepository: sl<DeviceRepository>()
  ));

  sl.registerFactory<GetGoatShedListUseCase>(() => GetGoatShedListUseCase(
      repository: sl<GoatShedRepository>()
  ));

  sl.registerFactory<GetGoatShedDetailUseCase>(() => GetGoatShedDetailUseCase(
      goatShedRepository: sl<GoatShedRepository>()
  ));

  sl.registerFactory<ChangeShedNameUseCase>(() => ChangeShedNameUseCase(
      repository: sl<GoatShedRepository>()
  ));

  sl.registerFactory<ChangeShedLocationUseCase>(() => ChangeShedLocationUseCase(
      repository: sl<GoatShedRepository>()
  ));

  sl.registerFactory<ChangeTotalGoatsUseCase>(() => ChangeTotalGoatsUseCase(
      repository: sl<GoatShedRepository>()
  ));

  sl.registerFactory<ChangeShedImageUseCase>(() => ChangeShedImageUseCase(
      repository: sl<GoatShedRepository>()
  ));
}