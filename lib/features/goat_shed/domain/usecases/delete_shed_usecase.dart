import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class DeleteShedUseCase {
  final GoatShedRepository repository;
  DeleteShedUseCase({ required this.repository });

  AsyncVoidResult call ({ required String shedId }) async {
    return await repository.deleteShed(shedId: shedId);
  }
}