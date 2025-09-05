import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/shared/launcher/domain/usecases/open_whatsapp_usecase.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/usecases/watch_user_data_usecase.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthViewModel _authViewmodel;
  final WatchUserDataUseCase _watchUserDataUseCase;
  final OpenWhatsappUseCase openWhatsappUseCase;
  StreamSubscription? _userSub;

  UserEntity? _user;
  UserEntity? get user => _user;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ProfileViewModel({
    required AuthViewModel authViewmodel,
    required WatchUserDataUseCase watchUserDataUseCase,
    required this.openWhatsappUseCase
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

  AsyncVoidResult openWhatsapp() async {
    return await openWhatsappUseCase.call(name: user!.name);
  }

  Future<void> logout() async {
    return await _authViewmodel.logout();
  }

  @override
  void dispose() {
    _authViewmodel.removeListener(_onAuthChanged);
    _userSub?.cancel();
    super.dispose();
  }
}
