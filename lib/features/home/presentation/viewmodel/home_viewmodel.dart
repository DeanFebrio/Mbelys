import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_list_usecase.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

enum HomeState { initial, loading, success, error }

class HomeViewModel extends ChangeNotifier {
  final ProfileViewModel _profileViewModel;
  final GetGoatShedListUseCase getGoatShedListUseCase;

  HomeViewModel ({
    required ProfileViewModel profileViewModel,
    required this.getGoatShedListUseCase
  }) : _profileViewModel = profileViewModel{
    _profileViewModel.addListener(_onProfileChanged);
    _listenToGoatSheds();
  }

  void _onProfileChanged() {
    _listenToGoatSheds();
  }

  HomeState _state = HomeState.initial;
  HomeState get state => _state;

  UserEntity? get user => _profileViewModel.user;
  String? get name => user?.name;

  StreamSubscription? shedSubs;

  String? _errorMesssage;
  String? get errorMessage => _errorMesssage;

  List<GoatShedEntity> _sheds = [];
  List<GoatShedEntity> get sheds => _sheds;

  void _listenToGoatSheds () {
    shedSubs?.cancel();

    final userId = user?.id;
    if (userId == null) {
      _sheds = [];
      _state = HomeState.success;
      notifyListeners();
      return;
    }

    _state = HomeState.loading;
    notifyListeners();

    shedSubs = getGoatShedListUseCase.call(ownerId: userId).listen(
      (shedList) {
        _sheds = shedList;
        _state = HomeState.success;
        notifyListeners();
      },
      onError: (error) {
          _state = HomeState.error;
          _errorMesssage = "Terjadi masalah pada koneksi data!";
          notifyListeners();
      }
    );
  }

  Future<void> refresh () async {
    _listenToGoatSheds();
  }

  @override
  void dispose() {
    _profileViewModel.removeListener(_onProfileChanged);
    shedSubs?.cancel();
    super.dispose();
  }
}