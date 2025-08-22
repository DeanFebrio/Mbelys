import 'package:flutter/material.dart';
import 'package:mbelys/domain/entities/user_entity.dart';
import 'package:mbelys/presentation/auth/viewmodel/auth_viewmodel.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthViewmodel _authViewmodel;

  UserEntity? _user;
  UserEntity? get user => _user;

  ProfileViewModel({
    required AuthViewmodel authViewmodel
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

  @override
  void dispose() {
    _authViewmodel.removeListener(_onAuthChanged);
    super.dispose();
  }


}