import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';

  class AuthModel extends AuthEntity {
    AuthModel({
      required super.userId,
      required super.email,
    });
  }