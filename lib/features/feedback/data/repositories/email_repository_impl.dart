import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/feedback/data/datasources/email_datasource.dart';
import 'package:mbelys/features/feedback/data/models/email_model.dart';
import 'package:mbelys/features/feedback/domain/entities/email_entity.dart';
import 'package:mbelys/features/feedback/domain/repositories/email_repostory.dart';

class EmailRepositoryImpl implements EmailRepository {
  final EmailDataSource emailDataSource;
  const EmailRepositoryImpl ({ required this.emailDataSource });

  @override
  AsyncVoidResult sendEmail ({required EmailEntity email}) async {
    try {
      final emailModel = EmailModel(
          userId: email.userId,
          email: email.email,
          name: email.name,
          message: email.message
      );
      await emailDataSource.sendEmail(emailModel: emailModel);
      return okVoidAsync();
    } catch (e) {
      return errVoidAsync(NetworkFailure(e.toString()));
    }
  }
}
