import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mbelys/domain/entities/user_entity.dart';
import 'package:mbelys/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/domain/usecases/get_user_data_usecase.dart';
import 'package:mbelys/domain/usecases/logout_usecase.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthViewmodel extends ChangeNotifier {
  final GetUserDataUseCase _getUserDataUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetAuthStateUseCase _getAuthStateUseCase;

  StreamSubscription? _authStreamSubscription;

  AuthStatus _status = AuthStatus.unknown;
  AuthStatus get status => _status;

  UserEntity? _user;
  UserEntity? get user => _user;

  AuthViewmodel ({
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
    _authStreamSubscription = _getAuthStateUseCase.call().listen((firebaseUser) async {
      if (firebaseUser != null) {
        final result = await _getUserDataUseCase.call(firebaseUser.uid);
        result.fold(
            (failure) {
              _user = null;
              _status = AuthStatus.unauthenticated;
            },
            (userEntity) {
              _user = userEntity;
              _status = AuthStatus.authenticated;
            }
        );
      } else {
        _user = null;
        _status = AuthStatus.unauthenticated;
      }
      notifyListeners();
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