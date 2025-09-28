import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class ChangeShedImageUseCase {
  final GoatShedRepository repository;
  ChangeShedImageUseCase ({ required this.repository });

  AsyncVoidResult call ({ required String shedId, required File newImageFile }) async {
    return await repository.changeGoatShedImage(shedId: shedId, newImageFile: newImageFile);
  }
}