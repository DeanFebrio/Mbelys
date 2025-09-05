import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/feedback/domain/repositories/email_repostory.dart';
import 'package:mbelys/features/feedback/domain/usecases/send_email_usecase.dart';

Future<void> initFeedbackDomain () async {
  sl.registerFactory<SendEmailUseCase>(() => SendEmailUseCase(
      emailRepository: sl<EmailRepository>()
  ));
}