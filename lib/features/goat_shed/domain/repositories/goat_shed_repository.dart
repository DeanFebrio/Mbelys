import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';

abstract class GoatShedRepository {
  AsyncResult<void> createGoatShed ({ required GoatShedEntity goatShed, required File imageFile });
  Stream<List<GoatShedEntity>> getGoatShedList ({ required String ownerId });
  Stream<GoatShedEntity> getGoatShedDetail ({ required String shedId });
}