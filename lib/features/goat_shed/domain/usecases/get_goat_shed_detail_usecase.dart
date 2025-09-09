import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class GetGoatShedDetailUseCase {
  final GoatShedRepository goatShedRepository;
  const GetGoatShedDetailUseCase({required this.goatShedRepository});

  Stream<GoatShedEntity> call ({required String shedId}) {
    return goatShedRepository.getGoatShedDetail(shedId: shedId);
  }
}