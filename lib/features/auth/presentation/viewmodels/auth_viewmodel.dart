import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';
import 'package:mbelys/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/usecases/get_user_data_usecase.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthViewModel extends ChangeNotifier {
  final GetAuthStateUseCase _getAuthState;
  final GetUserDataUseCase _getUserData;
  final LogoutUseCase _logoutUseCase;

  StreamSubscription<AuthEntity?>? _sub;

  AuthStatus _status = AuthStatus.unknown;
  AuthStatus get status => _status;

  AuthEntity? _auth;
  AuthEntity? get auth => _auth;

  UserEntity? _user;
  UserEntity? get user => _user;

  bool _loadingProfile = false;
  bool get loadingProfile => _loadingProfile;

  String? _error;
  String? get error => _error;

  AuthViewModel({
    required GetAuthStateUseCase getAuthState,
    required GetUserDataUseCase getUserData,
    required LogoutUseCase logoutUseCase
  }) : _getAuthState = getAuthState,
      _getUserData = getUserData,
      _logoutUseCase = logoutUseCase{
        _listenAuth();
  }

  void _listenAuth () {
    _sub = _getAuthState.call().listen((authEntity) async {
      _error = null;
      if (authEntity == null) {
        _auth = null;
        _user = null;
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return;
      }

      if (_auth?.uid == authEntity.uid && _user != null) {
        _auth = authEntity;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return;
      }

      _auth  = authEntity;
      _status = AuthStatus.authenticated;
      _loadingProfile = true;
      notifyListeners();
      print(authEntity.uid);
      final res = await _getUserData.call(authEntity.uid);
      print("Res: ${res.getOrNull()}");
      _loadingProfile = false;
      _user = res.getOrNull();
      print("user: ${_user?.uid}");
      _error = res.failureOrNull()?.message;
      notifyListeners();
    });
  }

  Future<void> logout() async {
    final result = await _logoutUseCase.call();
    result.failureOrNull();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}