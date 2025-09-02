import 'package:flutter/cupertino.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/usecases/forgot_usecase.dart';

enum ForgotState { initial, loading, success, error }

class ForgotViewModel extends ChangeNotifier {
  final ForgotUseCase forgotUseCase;

  ForgotViewModel({ required this.forgotUseCase});

  ForgotState _state = ForgotState.initial;
  ForgotState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  String? validateEmail (String? value){
    if (value == null || value.isEmpty) return "Email Wajib diisi";
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value)) return "Format email tidak valid!";
    return null;
  }

  AsyncVoidResult forgotPassword () async {
    if (!formKey.currentState!.validate()) return err(AuthFailure("Perhatikan input!"));
    final email = emailController.text.trim();

    _state = ForgotState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await forgotUseCase.call(email: email);

    result.fold(
        (failure) {
          _errorMessage = failure.message;
          _state = ForgotState.error;
        },
        (success) {
          _state = ForgotState.success;
        }
    );
    notifyListeners();
    return okUnit();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

}