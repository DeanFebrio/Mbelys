import 'package:flutter/cupertino.dart';
import 'package:mbelys/features/auth/domain/usecases/register_usecase.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

enum RegisterState { initial, loading, success, error }

class RegisterViewModel extends ChangeNotifier {
  final RegisterUseCase registerUseCase;
  RegisterViewModel({required this.registerUseCase});

  UserEntity? _user;
  UserEntity? get user => _user;

  RegisterState _state = RegisterState.initial;
  RegisterState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> register () async {
    if (!formKey.currentState!.validate()) return;

    _state = RegisterState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await registerUseCase.call(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
        phoneController.text.trim()
    );
    result.fold(
        (failure) {
          _errorMessage = failure.message;
          _state = RegisterState.error;
        },
        (userEntity) {
          _user = userEntity;
          _state = RegisterState.success;
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

  String? validateName (String? value){
    if (value == null || value.isEmpty) return "Nama wajib diisi";
    if (value.length > 15) return "Maksimal 15 karakter";
    return null;
  }

  String? validatePhone (String? value) {
    if (value == null || value.isEmpty) return "Nomor telepon wajib diisi";
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "Nomor telepon harus angka";
    if (value.length < 10 || value.length > 13) return "Nomor telepon harus 10-13 angka";
    return null;
  }
}