import 'package:flutter/cupertino.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthViewModel _authViewModel;

  HomeViewModel ({
    required AuthViewModel authViewModel
  }) : _authViewModel = authViewModel;

  UserEntity? get user => _authViewModel.user;
  String? get name => user?.name;
}