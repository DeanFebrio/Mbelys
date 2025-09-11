import 'package:flutter/cupertino.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/feedback/domain/entities/email_entity.dart';
import 'package:mbelys/features/feedback/domain/usecases/send_email_usecase.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

enum FeedbackState { initial, loading, success, error }

class FeedbackViewModel extends ChangeNotifier {
  final SendEmailUseCase sendEmailUseCase;
  final ProfileViewModel _profileViewModel;
  
  FeedbackViewModel({
    required this.sendEmailUseCase,
    required ProfileViewModel profileViewModel
  }) : _profileViewModel = profileViewModel{
    _profileViewModel.addListener(_onProfileChanged);
  }

  void _onProfileChanged() {
    notifyListeners();
  }

  FeedbackState _state = FeedbackState.initial;
  FeedbackState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  UserEntity? get user => _profileViewModel.user;
  final feedbackController = TextEditingController();
  
  AsyncVoidResult sendEmail () async {
    final message = feedbackController.text.trim();

    if (message.isEmpty) {
      _state = FeedbackState.error;
      _errorMessage = "Harap isi kritik dan saran anda!";
      notifyListeners();
      return okUnit();
    }

    if (user == null) {
      _state = FeedbackState.error;
      _errorMessage = "Pengguna tidak ada!";
      notifyListeners();
      return okUnit();
    }

    _state = FeedbackState.loading;
    _errorMessage = null;
    notifyListeners();

    EmailEntity email = EmailEntity(
        uid: user!.id,
        email: user!.email,
        name: user!.name,
        message: message
    );

    final result = await sendEmailUseCase.call(email: email);

    result.fold(
        (failure) {
          _state = FeedbackState.error;
          _errorMessage = failure.message;
          notifyListeners();
        },
        (data) {
          _state = FeedbackState.success;
          notifyListeners();
        }
    );
    return okUnit();
  }

  void resetState () {
    _state = FeedbackState.initial;
    notifyListeners();
  }

  @override
  void dispose() {
    _profileViewModel.removeListener(_onProfileChanged);
    feedbackController.dispose();
    super.dispose();
  }
}