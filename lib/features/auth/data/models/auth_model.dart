import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';

  class AuthModel extends AuthEntity {
    AuthModel({
      required super.uid,
      required super.email,
    });
  }