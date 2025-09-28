import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class ChangeShedNameUseCase {
  final GoatShedRepository repository;
  ChangeShedNameUseCase ({ required this.repository });

  AsyncVoidResult call ({ required String shedId, required String newName }) async {
    return await repository.changeGoatShedName(shedId: shedId, newName: newName);
  }
}