import 'package:flutter/cupertino.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

class HomeViewModel extends ChangeNotifier {
  final ProfileViewModel _profileViewModel;

  HomeViewModel ({
    required ProfileViewModel profileViewModel
  }) : _profileViewModel = profileViewModel{
    _profileViewModel.addListener(_onProfileChanged);
  }

  void _onProfileChanged() {
    notifyListeners();
  }

  UserEntity? get user => _profileViewModel.user;
  String? get name => user?.name;

  @override
  void dispose() {
    _profileViewModel.removeListener(_onProfileChanged);
    super.dispose();
  }
}