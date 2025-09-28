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

  ProfileViewModel({
    required AuthViewModel authViewmodel,
    required WatchUserDataUseCase watchUserDataUseCase,
    required this.openWhatsappUseCase
  }) :
      _authViewmodel = authViewmodel,
      _watchUserDataUseCase = watchUserDataUseCase
  {
    _authViewmodel.addListener(onAuthChanged);
    onAuthChanged();
  }

  UserEntity? _user;
  UserEntity? get user => _user;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool disposed = false;

  void onAuthChanged () {
    _userSub?.cancel();
    _errorMessage = null;

    final auth = _authViewmodel.auth;
    if (auth == null) {
      _user = null;
      _isLoading = false;
      safeNotify();
      return;
    }

    _isLoading = true;
    safeNotify();
    _userSub = _watchUserDataUseCase.call(uid: auth.uid).listen((result) {
      _user = result;
      _isLoading = false;
      notifyListeners();
    });

  }

  AsyncVoidResult openWhatsapp() async {
    return await openWhatsappUseCase.call(name: user!.name);
  }

  Future<void> logout() async {
    return await _authViewmodel.logout();
  }

  void safeNotify() {
    if (!disposed) notifyListeners();
  }

  @override
  void dispose() {
    _authViewmodel.removeListener(onAuthChanged);
    _userSub?.cancel();
    super.dispose();
  }
}
