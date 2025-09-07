import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';

abstract class GoatShedRepository {
  AsyncResult<void> createGoatShed ({ required GoatShedEntity goatShed });
  Stream<List<GoatShedEntity>> getGoatShedList ({ required String ownerId });
}