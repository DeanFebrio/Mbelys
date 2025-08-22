import 'package:flutter/cupertino.dart';
import 'package:mbelys/domain/entities/user_entity.dart';
import 'package:mbelys/presentation/auth/viewmodel/auth_viewmodel.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthViewmodel _authViewmodel;

  UserEntity? _user;
  UserEntity? get user => _user;

  HomeViewModel ({
    required AuthViewmodel authViewmodel
  }) :
      _authViewmodel = authViewmodel {
    _authViewmodel.addListener(_onAuthChanged);
    _onAuthChanged;
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