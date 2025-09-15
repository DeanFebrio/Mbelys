import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class ChangeTotalGoatsUseCase {
  final GoatShedRepository repository;
  ChangeTotalGoatsUseCase({required this.repository});

  AsyncVoidResult call ({ required String shedId, required int newTotal }) async {
    return await repository.changeTotalGoats(shedId: shedId, newTotal: newTotal);
  }
}