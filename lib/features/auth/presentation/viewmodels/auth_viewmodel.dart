import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mbelys/features/auth/domain/entities/auth_entity.dart';
import 'package:mbelys/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/logout_usecase.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthViewModel extends ChangeNotifier {
  final GetAuthStateUseCase _getAuthState;
  final LogoutUseCase _logoutUseCase;

  AuthViewModel({
    required GetAuthStateUseCase getAuthState,
    required LogoutUseCase logoutUseCase
  }) : _getAuthState = getAuthState,
        _logoutUseCase = logoutUseCase{
    _listenAuth();
  }

  StreamSubscription<AuthEntity?>? _sub;

  AuthStatus _status = AuthStatus.unknown;
  AuthStatus get status => _status;

  AuthEntity? _auth;
  AuthEntity? get auth => _auth;

  bool get isAuthenticated => _status == AuthStatus.authenticated;

  bool _loadingProfile = false;
  bool get loadingProfile => _loadingProfile || _status == AuthStatus.unknown;

  String? _error;
  String? get error => _error;

  void _listenAuth () {
    _sub?.cancel();
    _sub = _getAuthState.call().listen((authEntity) async {
      _error = null;
      if (authEntity == null) {
        _auth = null;
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return;
      } else {
        _auth = authEntity;
        _status = AuthStatus.authenticated;
      }
      notifyListeners();
    });
  }

  Future<void> logout() async {
    final result = await _logoutUseCase.call();
    result.fold(
        (failure) {
          _error = failure.message;
        },
        (_) {
          _status = AuthStatus.unauthenticated;
        }
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}