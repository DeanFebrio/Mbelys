import 'package:mbelys/features/feedback/domain/entities/email_entity.dart';

class EmailModel extends EmailEntity {
  EmailModel ({
    required super.userId,
    required super.email,
    required super.name,
    required super.message
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'message': message,
    };
  }
}