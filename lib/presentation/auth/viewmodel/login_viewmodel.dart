import 'package:flutter/material.dart';
import 'package:mbelys/domain/entities/user_entity.dart';
import 'package:mbelys/domain/usecases/login_usecase.dart';

enum LoginState { initial, loading, success, error }

class LoginViewModel extends ChangeNotifier{
  final LoginUseCase loginUseCase;
  LoginViewModel({required this.loginUseCase});

  UserEntity? _user;
  UserEntity? get user => _user;

  LoginState _state = LoginState.initial;
  LoginState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login () async {
    if (!formKey.currentState!.validate()) return;

    _state = LoginState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await loginUseCase.call(
        emailController.text,
        passwordController.text
    );

    result.fold(
        (failure) {
          _errorMessage = failure.message;
          _state = LoginState.error;
        },
        (userEntity) {
          _user = userEntity;
          _state = LoginState.success;
        }
    );
    notifyListeners();
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