import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class GetGoatShedListUseCase {
  final GoatShedRepository repository;
  const GetGoatShedListUseCase ({ required this.repository });

  Stream<List<GoatShedEntity>> call ({ required String ownerId }) {
    return repository.getGoatShedList(userId: ownerId);
  }
}