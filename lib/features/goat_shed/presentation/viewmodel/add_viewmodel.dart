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

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final totalController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    totalController.dispose();
    super.dispose();
  }

  AsyncResult<void> addGoatShed () async {
    if(!formKey.currentState!.validate()) {
      _state = AddState.error;
      _errorMessage = "Input tidak valid!";
      notifyListeners();
      return err(NetworkFailure("Input tidak valid!"));
    }

    _state = AddState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = _profileViewModel.user;
      final goatShed = GoatShedEntity(
          id: "",
          name: nameController.text.trim(),
          location: locationController.text.trim(),
          total: int.parse(totalController.text.trim()),
          ownerId: user!.uid
      );

      final result = await createGoatShed.call(goatShed: goatShed);

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

  String? validateName (String? value) {
    if (value == null || value.isEmpty) return "Nama kandang wajib diisi";
    if (value.length < 3 || value.length > 20) return "Panjang nama kandang 3-20 karakter";
    return null;
  }

  String? validateLocation (String? value) {
    if (value == null || value.isEmpty) return "Lokasi kandang wajib diisi";
    return null;
  }

  String? validateTotal (String? value) {
    if (value == null || value.isEmpty) return "Jumlah kambing wajib diisi";
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "Jumlah kambing harus angka";
    return null;
  }
}