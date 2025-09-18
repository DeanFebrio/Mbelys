import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/create_goat_shed_usecase.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

enum AddState {initial, loading, success, error }

class AddViewModel extends ChangeNotifier {
  final CreateGoatShedUseCase createGoatShed;
  final ProfileViewModel _profileViewModel;
  AddViewModel({
    required this.createGoatShed,
    required ProfileViewModel profileViewModel
  }) : _profileViewModel = profileViewModel {
    _profileViewModel.addListener(_onProfileChanged);
  }

  void _onProfileChanged() {
    notifyListeners();
  }

  AddState _state = AddState.initial;
  AddState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  File? _localPhoto;
  File? get localPhoto => _localPhoto;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final totalController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    totalController.dispose();
    _profileViewModel.removeListener(_onProfileChanged);
    super.dispose();
  }

  void setImage (File image){
    _localPhoto = image;
    notifyListeners();
  }

  AsyncResult<void> addGoatShed () async {
    if(!(formKey.currentState?.validate() ?? false)) {
      _state = AddState.error;
      _errorMessage = "Input tidak valid!";
      notifyListeners();
      return err(NetworkFailure("Input tidak valid!"));
    }

    if (localPhoto == null) {
      _state = AddState.error;
      _errorMessage = "Foto tidak boleh kosong!";
      notifyListeners();
      return err(StorageFailure("Foto tidak boleh kosong!"));
    }

    _state = AddState.loading;
    _errorMessage = null;
    notifyListeners();

    final user = _profileViewModel.user;
    if (user == null) {
      _state = AddState.error;
      _errorMessage = "Pengguna tidak ditemukan!";
      notifyListeners();
      return err(DatabaseFailure("Pengguna tidak ditemukan!"));
    }

    try {
      final goatShed = GoatShedEntity(
          shedId: "",
          shedName: nameController.text.trim(),
          shedLocation: locationController.text.trim(),
          totalGoats: int.parse(totalController.text.trim()),
          ownerId: user.id
      );

      final result = await createGoatShed.call(goatShed: goatShed, imageFile: _localPhoto!);

      result.fold(
              (failure) {
            _errorMessage = failure.message;
            _state = AddState.error;
            notifyListeners();
          },
              (_) {
            _state = AddState.success;
            notifyListeners();
          }
      );
      return okUnit();
    } catch (e) {
      final msg = e is FirebaseException
          ? e.message ?? "Gagal menyimpan kandang (Firebase)."
          : "Terjadi kesalahan tak terduga.";
      _errorMessage = msg;
      _state = AddState.error;
      notifyListeners();
      return err(NetworkFailure(msg));
    }
  }

  String? validateName (String? name) {
    final value = (name ?? "").trim();
    if (value.isEmpty) return "Nama kandang wajib diisi!";
    if (value.length < 3 || value.length > 20) return "Panjang nama kandang 3-20 karakter";
    return null;
  }

  String? validateLocation (String? location) {
    final value = (location ?? "").trim();
    if (value.isEmpty) return "Lokasi kandang wajib diisi";
    if (value.length > 250) return "Panjang lokasi kandang maksimal 250 karakter";
    return null;
  }

  String? validateTotal(String? total) {
    final value = (total ?? "").trim();
    if (value.isEmpty) return "Jumlah kambing wajib diisi";
    final n = int.tryParse(value);
    if (n == null) return "Jumlah kambing harus angka";
    if (n < 1) return "Jumlah kambing minimal 1";
    return null;
  }
}