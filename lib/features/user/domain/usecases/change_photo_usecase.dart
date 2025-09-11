import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class ChangePhotoUseCase {
  final UserRepository repository;
  ChangePhotoUseCase({required this.repository});

  AsyncVoidResult call ({ required File file, required String uid }) async {
    return await repository.changePhoto(file: file, uid: uid);
  }
}