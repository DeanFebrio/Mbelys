import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/feedback/domain/entities/email_entity.dart';
import 'package:mbelys/features/feedback/domain/repositories/email_repostory.dart';

class SendEmailUseCase {
  final EmailRepository emailRepository;
  SendEmailUseCase({
    required this.emailRepository
  });

  AsyncVoidResult call ({ required EmailEntity email }) async {
    return await emailRepository.sendEmail(email: email);
  }
}