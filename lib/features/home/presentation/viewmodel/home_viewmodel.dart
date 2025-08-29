import 'package:flutter/cupertino.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/presentation/viewmodel/profile_viewmodel.dart';

class HomeViewModel extends ChangeNotifier {
  final ProfileViewModel _profileViewModel;

  HomeViewModel ({
    required ProfileViewModel profileViewModel
  }) : _profileViewModel = profileViewModel;

  UserEntity? get user => _profileViewModel.user;
  String? get name => user?.name;
}