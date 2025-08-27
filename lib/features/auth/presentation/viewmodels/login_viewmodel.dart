import 'package:flutter/material.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';
import 'package:mbelys/features/auth/domain/usecases/login_usecase.dart';

enum LoginState { initial, loading, success, error }

class LoginViewModel extends ChangeNotifier{
  final LoginUseCase _loginUseCase;

  String? _error;
  String? get error => _error;

  LoginViewModel({required LoginUseCase loginUseCase}) : _loginUseCase = loginUseCase;

  LoginState _state = LoginState.initial;
  LoginState get state => _state;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  AsyncResult<AuthEntity> login () async {
    if (!formKey.currentState!.validate()) return err(AuthFailure("Masuk gagal!"));

    _state = LoginState.loading;
    _error = null;
    notifyListeners();

    final result = await _loginUseCase.call(
        emailController.text,
        passwordController.text
    );

    result.fold(
        (failure) {
          _error = failure.message;
          _state = LoginState.error;
        },
        (authEntity) {
          _state = LoginState.success;
        }
    );
    notifyListeners();
    return result;
  }

  String? validateEmail (String? value){
    if (value == null || value.isEmpty) return "Email Wajib diisi";
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value)) return "Format email tidak valid!";
    return null;
  }

  String? validatePassword (String? value){
    if (value == null || value.isEmpty) return "Password Wajib diisi";
    if (value.length < 8) return "Password minimal 8 karakter";
    if (!value.contains(RegExp(r'[A-Z]'))) return "Password harus memiliki 1 huruf kapital";
    if (!value.contains(RegExp(r'[0-9]'))) return "Password harus memiliki 1 angka";
    return null;
  }
}