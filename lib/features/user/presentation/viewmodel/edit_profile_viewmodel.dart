import 'package:flutter/cupertino.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/auth/domain/usecases/update_name_usecase.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';
import 'package:mbelys/features/user/domain/usecases/change_name_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/change_phone_usecase.dart';
import 'package:mbelys/features/user/presentation/viewmodel/profile_viewmodel.dart';

enum EditState {initial, loading, success, error}

class EditProfileViewModel extends ChangeNotifier {
  final ChangeNameUseCase changeNameUseCase;
  final UpdateNameUseCase updateNameUseCase;
  final ChangePhoneUseCase changePhoneUseCase;
  final ProfileViewModel _profileViewModel;

  UserEntity? _user;
  UserEntity? get user => _profileViewModel.user;

  EditState _state = EditState.initial;
  EditState get state => _state;

  String? _error;
  String? get error => _error;

  EditProfileViewModel({
    required this.changeNameUseCase,
    required this.changePhoneUseCase,
    required this.updateNameUseCase,
    required ProfileViewModel profileViewModel
  }) : _profileViewModel = profileViewModel {
    _profileViewModel.addListener(_onProfileChanged);
    _onProfileChanged();
  }

  void _onProfileChanged () {
    _user = _profileViewModel.user;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  String? validateName (String? value){
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

  AsyncVoidResult saveChanges () async {
    if (_state == EditState.loading) return okUnit();

    _state = EditState.loading;
    _error = null;
    notifyListeners();

    final currentUser = user;
    final oldName = currentUser?.name ?? "";
    final oldPhone = currentUser?.phone ?? "";

    try {
      final name = nameController.text.trim();
      final phone = phoneController.text.trim();

      if (!(formKey.currentState?.validate() ?? true)) {
        _state = EditState.error;
        _error = "Periksa kembali input";
        notifyListeners();
        return err(ValidationFailure("Periksa kembali input"));
      }

      final futures = <Future<void>>[];

      if (name.isNotEmpty && name != oldName) {
        futures.add(updateNameUseCase.call(name: name));
        futures.add(changeNameUseCase.call(name: name, uid: currentUser!.uid));
      }

      if (phone.isNotEmpty && phone != oldPhone) {
        futures.add(changePhoneUseCase.call(phone: phone, uid: currentUser!.uid));
      }

      await Future.wait(futures);

      _state = EditState.success;
      notifyListeners();
      return okUnit();
    } catch (e) {
      _state = EditState.error;
      _error = "Gagal melakukan perubahan!";
      notifyListeners();
      return err(ValidationFailure(e.toString()));
    }
  }

  @override
  void dispose() {
    _profileViewModel.removeListener(_onProfileChanged);
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

}