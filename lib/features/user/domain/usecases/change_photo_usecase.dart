import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';

class ChangePhotoUseCase {
  final UserRepository repository;
  ChangePhotoUseCase ({ required this.repository });

  AsyncVoidResult call ({ required String userId, required File imageFile }) async {
    return await repository.changeUserPhoto(userId: userId, imageFile: imageFile);
  }
}