import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class ChangeShedLocationUseCase {
  final GoatShedRepository repository;
  ChangeShedLocationUseCase ({ required this.repository });

  AsyncVoidResult call ({ required String shedId, required String newLocation }) async {
    return await repository.changeGoatShedLocation(shedId: shedId, newLocation: newLocation);
  }
}