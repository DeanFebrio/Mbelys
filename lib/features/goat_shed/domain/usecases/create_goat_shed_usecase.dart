import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class CreateGoatShedUseCase {
  final GoatShedRepository goatShedRepository;
  const CreateGoatShedUseCase({required this.goatShedRepository});

  AsyncResult<void> call ({required GoatShedEntity goatShed}) async {
    return await goatShedRepository.createGoatShed(goatShed: goatShed);
  }
}