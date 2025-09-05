import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/feedback/data/datasources/email_datasource.dart';
import 'package:mbelys/features/feedback/data/repositories/email_repository_impl.dart';
import 'package:mbelys/features/feedback/domain/repositories/email_repostory.dart';

Future<void> initFeedbackData () async {
  sl.registerLazySingleton<EmailDataSource>(() => EmailDataSource());

  sl.registerLazySingleton<EmailRepository>(() => EmailRepositoryImpl(
      emailDataSource: sl<EmailDataSource>()
  ));
}