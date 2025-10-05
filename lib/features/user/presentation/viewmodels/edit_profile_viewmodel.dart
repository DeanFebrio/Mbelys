import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/usecases/update_name_usecase.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/usecases/change_name_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/change_phone_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/change_photo_usecase.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

enum EditProfileState {initial, loading, success, error}

class EditProfileViewModel extends ChangeNotifier {
  final ChangeNameUseCase changeNameUseCase;
  final UpdateNameUseCase updateNameUseCase;
  final ChangePhoneUseCase changePhoneUseCase;
  final ChangePhotoUseCase changePhotoUseCase;
  final ProfileViewModel _profileViewModel;
  bool _seeded = false;

  EditProfileViewModel({
    required this.changeNameUseCase,
    required this.changePhoneUseCase,
    required this.updateNameUseCase,
    required this.changePhotoUseCase,
    required ProfileViewModel profileViewModel,
  }) : _profileViewModel = profileViewModel {
    _profileViewModel.addListener(_onProfileChanged);
    _onProfileChanged();
  }

  void _onProfileChanged () {
    final u = _profileViewModel.user;
    if (u == null || _seeded) return;
    _seeded = true;
    notifyListeners();
  }

  UserEntity? get user => _profileViewModel.user;

  EditProfileState _state = EditProfileState.initial;
  EditProfileState get state => _state;

  String? _error;
  String? get error => _error;

  File? _localPhoto;
  File? get localPhoto => _localPhoto;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  String? validateName (String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length < 3 || value.length > 15) return "Panjang nama 3-15 karakter";
    }
    return null;
  }

  String? validatePhone (String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "Nomor telepon harus angka";
      if (value.length < 10 || value.length > 13) return "Nomor telepon harus 10-13 angka";
    }
    return null;
  }

  void setImage (File image) async {
    _localPhoto = image;
    notifyListeners();
  }

  AsyncVoidResult saveChanges () async {
    if (_state == EditProfileState.loading) return okVoidAsync();

    _state = EditProfileState.loading;
    _error = null;
    notifyListeners();

    final currentUser = user;
    final oldName = currentUser?.name ?? "";
    final oldPhone = currentUser?.phoneNumber ?? "";

    try {
      final name = nameController.text.trim();
      final phone = phoneController.text.trim();

      if (!(formKey.currentState?.validate() ?? true)) {
        _state = EditProfileState.error;
        _error = "Periksa kembali input";
        notifyListeners();
        return err(ValidationFailure("Periksa kembali input"));
      }

      final futures = <Future<void>>[];

      if (name.isNotEmpty && name != oldName) {
        futures.add(updateNameUseCase.call(name: name));
        futures.add(changeNameUseCase.call(name: name, userId: currentUser!.userId));
      }

      if (phone.isNotEmpty && phone != oldPhone) {
        futures.add(changePhoneUseCase.call(phoneNumber: phone, userId: currentUser!.userId));
      }

      if (_localPhoto != null) {
        final res = await changePhotoUseCase.call(imageFile: _localPhoto!, userId: currentUser!.userId);

        final didFail = res.fold(
          (failure) {
            _error = failure.message;
            _state = EditProfileState.error;
            notifyListeners();
            return true;
          },
          (_) => false
        );

        if (didFail) return err(ServerFailure(_error!));
      }

      if (futures.isNotEmpty) {
        await Future.wait(futures);
      }

      _state = EditProfileState.success;
      _localPhoto = null;
      notifyListeners();
      return okVoidAsync();
    } catch (e) {
      _state = EditProfileState.error;
      _error = "Gagal melakukan perubahan!";
      notifyListeners();
      return err(ValidationFailure(e.toString()));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

}