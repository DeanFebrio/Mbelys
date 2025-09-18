import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/utils/failure_extensions.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_image_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_location_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_name_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_total_goats_usecase.dart';
import 'package:mbelys/features/goat_shed/presentation/viewmodel/detail_viewmodel.dart';

enum EditState { initial, loading, success, error }

class EditViewModel extends ChangeNotifier {
  final ChangeShedNameUseCase changeShedNameUseCase;
  final ChangeShedLocationUseCase changeShedLocationUseCase;
  final ChangeShedImageUseCase changeShedImageUseCase;
  final ChangeTotalGoatsUseCase changeTotalGoatsUseCase;
  final DetailViewModel _detailViewModel;

  EditViewModel({
    required this.changeShedNameUseCase,
    required this.changeShedLocationUseCase,
    required this.changeShedImageUseCase,
    required this.changeTotalGoatsUseCase,
    required DetailViewModel detailViewModel
  }) : _detailViewModel = detailViewModel {
    _detailViewModel.addListener(_onDetailChanged);
  }

  bool seeded = false;

  void _onDetailChanged () {
    final shed = _detailViewModel.goatShed;
    if (shed == null || seeded) return;
    seeded = true;
    notifyListeners();
  }

  GoatShedEntity? get shed => _detailViewModel.goatShed;

  EditState _state = EditState.initial;
  EditState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  File? _localPhoto;
  File? get localPhoto => _localPhoto;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final totalController = TextEditingController();

  void setImage (File image) {
    _localPhoto = image;
    notifyListeners();
  }

  AsyncVoidResult saveChanges () async {
    if (_state == EditState.loading) return okUnit();

    if (!(formKey.currentState?.validate() ?? false)) {
      _state = EditState.error;
      _errorMessage = "Periksa kembali input";
      notifyListeners();
      return errAsync(ValidationFailure("Periksa kembali input"));
    }

    if (shed == null) {
      _handleFailure(DatabaseFailure("Kandang tidak ditemukan!"));
      return err(DatabaseFailure("Kandang tidak ditemukan!"));
    }

    final shedName = nameController.text.trim();
    final shedLocation = locationController.text.trim();
    final totalGoats = totalController.text.trim();
    final imageFile = _localPhoto;

    if (shedName.isEmpty && shedLocation.isEmpty && totalGoats.isEmpty && imageFile == null) {
      _state = EditState.error;
      _errorMessage = "Periksa kembali input";
      notifyListeners();
      return err(ValidationFailure("Periksa kembali input"));
    }

    _state = EditState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      if (shedName.isNotEmpty && shedName != shed!.shedName) {
        final result = await changeShedNameUseCase.call(shedId: shed!.shedId, newName: shedName);
        if (result.isLeft()) return _handleFailure(result.failureOrNull()!);
      }

      if (shedLocation.isNotEmpty && shedLocation != shed!.shedLocation) {
        final result = await changeShedLocationUseCase.call(shedId: shed!.shedId, newLocation: shedLocation);
        if (result.isLeft()) return _handleFailure(result.failureOrNull()!);
      }

      if (totalGoats.isNotEmpty) {
        final newTotal = int.parse(totalGoats);
        if (newTotal != shed!.totalGoats) {
          final result = await changeTotalGoatsUseCase.call(shedId: shed!.shedId, newTotal: newTotal);
          if (result.isLeft()) return _handleFailure(result.failureOrNull()!);
        }
      }

      if (imageFile != null) {
        final result = await changeShedImageUseCase.call(shedId: shed!.shedId, newImageFile: imageFile);
        if (result.isLeft()) return _handleFailure(result.failureOrNull()!);
      }

      _state = EditState.success;
      _localPhoto = null;
      _detailViewModel.getGoatShedDetail(shedId: shed!.shedId);
      notifyListeners();
      return okUnit();
    } catch (e) {
      _state = EditState.error;
      _errorMessage = "Gagal melakukan perubahan!";
      notifyListeners();
      return err(ValidationFailure(e.toString()));
    }
  }

  AsyncVoidResult _handleFailure(Failure failure) async {
    _state = EditState.error;
    _errorMessage = failure.toUserMessage();
    notifyListeners();
    return errVoidAsync(failure);
  }

  String? validateName (String? name) {
    final value = (name ?? "").trim();
    if (value.isEmpty) return null;
    if (value == shed?.shedName) return "Nama kandang tidak berubah";
    if (value.length < 3 || value.length > 20) return "Panjang nama kandang 3-20 karakter";
    return null;
  }

  String? validateLocation (String? location) {
    final value = (location ?? "").trim();
    if (value.isEmpty) return null;
    if (value.length > 250) return "Panjang lokasi kandang maksimal 250 karakter";
    return null;
  }

  String? validateTotal(String? total) {
    final value = (total ?? "").trim();
    if (value.isEmpty) return null;
    final n = int.tryParse(value);
    if (n == shed?.totalGoats) return "Jumlah kambing tidak berubah";
    if (n == null) return "Jumlah kambing harus angka";
    if (n < 1) return "Jumlah kambing minimal 1";
    return null;
  }

  @override
  void dispose() {
    _detailViewModel.removeListener(_onDetailChanged);
    nameController.dispose();
    locationController.dispose();
    totalController.dispose();
    super.dispose();
  }
}