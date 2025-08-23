import 'package:dartz/dartz.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class GetUserDataUseCase {
  final UserRepository repository;
  GetUserDataUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call (String uid) async {
    return await repository.getUserData(uid);
  }
}