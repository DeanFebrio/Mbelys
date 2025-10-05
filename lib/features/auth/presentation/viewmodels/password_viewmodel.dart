import 'package:flutter/cupertino.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/usecases/change_password_usecase.dart';

enum PasswordState { initial, loading, success, error }

class PasswordViewModel extends ChangeNotifier {
  final ChangePasswordUseCase changePasswordUseCase;
  PasswordViewModel({
    required this.changePasswordUseCase
  });

  PasswordState _state = PasswordState.initial;
  PasswordState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? validatePassword (String? value) {
    if (value == null || value.isEmpty) return "Password Baru Wajib diisi";
    if (value.length < 8) return "Password minimal 8 karakter";
    if (!value.contains(RegExp(r'[A-Z]'))) return "Password harus memiliki 1 huruf kapital";
    if (!value.contains(RegExp(r'[0-9]'))) return "Password harus memiliki 1 angka";

    final oldPassword = oldPasswordController.text.trim();
    if (oldPassword == value) return "Password baru sama dengan yang lama";
    return null;
  }

  String? validateConfirmPassword (String? value) {
    final newPass = newPasswordController.text.trim();
    if (value == null || value.isEmpty) return "Konfirmasi Password Wajib diisi";
    if (value != newPass) return "Password tidak sama";
    return null;
  }

  AsyncVoidResult changePassword () async {
    if (!formKey.currentState!.validate()) return err(AuthFailure("Pendaftaran gagal!"));

    _state = PasswordState.loading;
    _errorMessage = null;
    notifyListeners();

    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final result = await changePasswordUseCase.call(oldPassword: oldPassword, newPassword: newPassword);

    result.fold(
        (failure) {
          _errorMessage = failure.message;
          _state = PasswordState.error;
        },
        (userEntity) {
          _state = PasswordState.success;
        }
    );
    notifyListeners();
    return okVoidAsync();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}