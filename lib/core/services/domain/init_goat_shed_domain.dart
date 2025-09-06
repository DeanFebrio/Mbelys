import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/create_goat_shed_usecase.dart';

Future<void> initGoatShedDomain () async {
  sl.registerFactory<CreateGoatShedUseCase>(() => CreateGoatShedUseCase(
      goatShedRepository: sl<GoatShedRepository>()
  ));
}