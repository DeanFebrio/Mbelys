import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/usecases/watch_user_data_usecase.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthViewModel _authViewmodel;
  final WatchUserDataUseCase _watchUserDataUseCase;
  StreamSubscription? _userSub;

  UserEntity? _user;
  UserEntity? get user => _user;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ProfileViewModel({
    required AuthViewModel authViewmodel,
    required WatchUserDataUseCase watchUserDataUseCase
  }) :
      _authViewmodel = authViewmodel,
      _watchUserDataUseCase = watchUserDataUseCase
  {
    _authViewmodel.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  void _onAuthChanged () {
    final auth = _authViewmodel.auth;
    _userSub?.cancel();

    if (auth != null) {
      _isLoading = true;
      notifyListeners();

      _userSub = _watchUserDataUseCase.call(uid: auth.uid).listen((result) {
        _user = result;
        _isLoading = false;
        notifyListeners();
      });
    } else {
      _user = null;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    return await _authViewmodel.logout();
  }
}