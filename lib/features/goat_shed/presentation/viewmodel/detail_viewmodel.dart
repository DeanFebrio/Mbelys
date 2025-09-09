import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_detail_usecase.dart';

enum DetailState { initial, loading, success, error }

class DetailViewModel extends ChangeNotifier {
  final GetGoatShedDetailUseCase getGoatShedDetail;
  final String shedId;

  DetailViewModel({
    required this.getGoatShedDetail,
    required this.shedId,
  }) {
    fetchShedDetail();
  }

  GoatShedEntity? _goatShed;
  GoatShedEntity? get goatShed => _goatShed;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DetailState _state = DetailState.initial;
  DetailState get state => _state;

  StreamSubscription<GoatShedEntity>? _shedSubs;
  bool _disposed = false;

  void fetchShedDetail() {
    _setState(DetailState.loading);
    _errorMessage = null;

    _shedSubs?.cancel();

    _shedSubs = getGoatShedDetail.call(shedId: shedId).listen(
          (shed) {
        _goatShed = shed;
        _setState(DetailState.success);
      },
      onError: (_) {
        _errorMessage = "Gagal mengambil data kandang kambing!";
        _setState(DetailState.error);
      },
    );
  }

  void retry() => fetchShedDetail();

  void _setState(DetailState s) {
    if (_disposed) return;
    _state = s;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _shedSubs?.cancel();
    super.dispose();
  }
}
