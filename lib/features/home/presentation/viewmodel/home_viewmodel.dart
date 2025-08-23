import 'package:flutter/cupertino.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthViewModel _authViewmodel;

  UserEntity? _user;
  UserEntity? get user => _user;

  HomeViewModel ({
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

  @override
  void dispose() {
    _authViewmodel.removeListener(_onAuthChanged);
    super.dispose();
  }
}