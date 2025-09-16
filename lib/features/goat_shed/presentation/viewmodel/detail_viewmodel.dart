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
    subscribe(initial: true);
  }

  GoatShedEntity? _goatShed;
  GoatShedEntity? get goatShed => _goatShed;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DetailState _state = DetailState.initial;
  DetailState get state => _state;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  StreamSubscription<GoatShedEntity>? _shedSubs;
  bool _disposed = false;

  void subscribe({ bool initial = false }) {
    _shedSubs?.cancel();
    if (initial) _setState(DetailState.loading);
    _errorMessage = null;

    _shedSubs = getGoatShedDetail.call(shedId: shedId).listen(
          (shed) {
        _goatShed = shed;
        _setState(DetailState.success);
        if (_isRefreshing) {
          _isRefreshing = false;
          notifyListeners();
        }
      },
      onError: (_) {
        _errorMessage = "Gagal mengambil data kandang kambing!";
        if (_goatShed == null) {
          _setState(DetailState.error);
        } else {
          _isRefreshing = false;
          notifyListeners();
        }
      },
    );
  }

  Future<void> refresh() async {
    if (_disposed) return;
    if (_goatShed == null) {
      subscribe(initial: true);
    } else {
      _isRefreshing = true;
      notifyListeners();
      subscribe(initial: false);
    }
  }

  void retry() => subscribe(initial: true);

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
