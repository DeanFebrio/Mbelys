import 'package:flutter/material.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthViewModel _authViewmodel;

  UserEntity? _user;
  UserEntity? get user => _user;

  ProfileViewModel({
    required AuthViewModel authViewmodel
  }) :
      _authViewmodel = authViewmodel {
    _authViewmodel.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  void _onAuthChanged () {
    _user = _authViewmodel.user;
    notifyListeners();
  }

  Future<void> logout() async {
    return await _authViewmodel.logout();
  }
}