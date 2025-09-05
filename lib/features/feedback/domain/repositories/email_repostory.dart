import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/feedback/domain/entities/email_entity.dart';

abstract class EmailRepository {
  AsyncVoidResult sendEmail ({required EmailEntity email});
}