import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';

abstract class GoatShedRepository {
  AsyncVoidResult createGoatShed ({ required GoatShedEntity goatShed, required File imageFile });
  Stream<List<GoatShedEntity>> getGoatShedList ({ required String ownerId });
  Stream<GoatShedEntity> getGoatShedDetail ({ required String shedId });

  AsyncVoidResult changeGoatShedName ({ required String shedId, required String newName });
  AsyncVoidResult changeGoatShedLocation ({ required String shedId, required String newLocation });
  AsyncVoidResult changeTotalGoats ({ required String shedId, required int newTotal });
  AsyncVoidResult changeGoatShedImage ({ required String shedId, required File newImageFile });
}