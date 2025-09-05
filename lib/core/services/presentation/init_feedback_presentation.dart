import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/feedback/domain/usecases/send_email_usecase.dart';
import 'package:mbelys/features/feedback/presentation/viewmodels/feedback_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

Future<void> initFeedbackPresentation () async {
  sl.registerFactory<FeedbackViewModel>(() => FeedbackViewModel(
      sendEmailUseCase: sl<SendEmailUseCase>(),
      profileViewModel: sl<ProfileViewModel>()
  ));
}