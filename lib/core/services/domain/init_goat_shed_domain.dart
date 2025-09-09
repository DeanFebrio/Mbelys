import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/create_goat_shed_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_detail_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_list_usecase.dart';

Future<void> initGoatShedDomain () async {
  sl.registerFactory<CreateGoatShedUseCase>(() => CreateGoatShedUseCase(
      goatShedRepository: sl<GoatShedRepository>()
  ));

  sl.registerFactory<GetGoatShedListUseCase>(() => GetGoatShedListUseCase(
      repository: sl<GoatShedRepository>()
  ));

  sl.registerFactory<GetGoatShedDetailUseCase>(() => GetGoatShedDetailUseCase(
      goatShedRepository: sl<GoatShedRepository>()
  ));
}