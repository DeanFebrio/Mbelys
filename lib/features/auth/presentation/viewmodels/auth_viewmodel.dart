import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mbelys/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/usecases/get_user_data_usecase.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthViewModel extends ChangeNotifier {
  final GetUserDataUseCase _getUserDataUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetAuthStateUseCase _getAuthStateUseCase;

  StreamSubscription? _authStreamSubscription;

  AuthStatus _status = AuthStatus.unknown;
  AuthStatus get status => _status;

  UserEntity? _user;
  UserEntity? get user => _user;

  AuthViewModel ({
    required GetUserDataUseCase getUserDataUseCase,
    required LogoutUseCase logoutUseCase,
    required GetAuthStateUseCase getAuthStateUseCase
  }) :
        _getUserDataUseCase = getUserDataUseCase,
        _logoutUseCase = logoutUseCase,
        _getAuthStateUseCase = getAuthStateUseCase
  {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges () {
    _authStreamSubscription?.cancel();
    _authStreamSubscription = _getAuthStateUseCase.call().listen((firebaseUser) async {

      if (firebaseUser == null) {
        _user = null;
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return;
      }

      if (_status != AuthStatus.authenticated) {
       _status = AuthStatus.authenticated;
       notifyListeners();
      }

      try {
        final result = await _getUserDataUseCase.call(firebaseUser.uid);
        result.fold(
            (failure) {
              _status = AuthStatus.unauthenticated;
              _user = null;
            },
            (userEntity) {
              _user = userEntity;
              print("user: ${_user?.name}");
              _status = AuthStatus.authenticated;
              print("status: ${_status}");
            }
        );
        notifyListeners();
      } catch (_) {
        _user = null;
        notifyListeners();
      }
    });
  }

  Future<void> logout() async {
    await _logoutUseCase.call();
  }

  @override void dispose() {
    _authStreamSubscription?.cancel();
    super.dispose();
  }
}