import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:mbelys/features/device/domain/usecases/ensure_device_registered.dart';
import 'package:mbelys/features/device/domain/usecases/register_device_usecase.dart';
import 'package:permission_handler/permission_handler.dart';

enum ProvisionStatus {
  idle,
  connectingDevice,
  connectedDevice,
  provisioning,
  wifiConnected,
  wifiFailed,
}

class ProvisionViewModel extends ChangeNotifier {
  final RegisterDeviceUseCase registerDeviceUseCase;
  final EnsureDeviceRegisteredUseCase ensureDeviceRegisteredUseCase;
  ProvisionViewModel({
    required this.registerDeviceUseCase,
    required this.ensureDeviceRegisteredUseCase,
  });

  ProvisionStatus _status = ProvisionStatus.idle;
  ProvisionStatus get status => _status;

  String _message = "";
  String get message => _message;

  String? _currentDeviceId;
  String? get currentDeviceId => _currentDeviceId;

  bool get isConnected => _connection?.isConnected == true;
  bool get isBusy =>
      _status == ProvisionStatus.connectingDevice || _status == ProvisionStatus.provisioning;

  final ssidController = TextEditingController();
  final passController = TextEditingController();

  BluetoothConnection? _connection;
  StreamSubscription<Uint8List>? _inputSub;
  StreamSubscription<BluetoothDiscoveryResult>? _discoverySub;
  final StringBuffer _lineBuf = StringBuffer();

  Timer? _wifiWaitTimer;
  Completer<String?>? _pendingGetId;
  Completer<bool>? _pendingSetId;

  static const _okMarkers = [
    "WIFI_OK",
    "WIFI CONNECTED",
    "CONNECTED TO WIFI",
    "CONNECTED",
    "IP:",
  ];
  static const _failMarkers = [
    "WIFI_FAIL",
    "FAIL",
    "WRONG PASSWORD",
    "NO SSID",
    "WIFI DISCONNECTED",
  ];

  Future<void> connect(BuildContext context) async {
    if (isBusy || isConnected) return;
    try {
      set(ProvisionStatus.connectingDevice, message: 'Menghubungkan ke perangkat…');

      await ensurePermissions();
      await cancelDiscoverySafely();
      if (!await _ensureBtEnabled()) {
        set(ProvisionStatus.idle, message: 'Bluetooth tidak aktif.');
        return;
      }

      final device = await pickDevice(context);
      if (device == null) {
        set(ProvisionStatus.idle, message: 'Dibatalkan.');
        return;
      }

      _setMessage('Menghubungkan ke ${device.name ?? device.address} …');
      final conn = await BluetoothConnection.toAddress(device.address);
      _connection = conn;

      await _inputSub?.cancel();
      _inputSub = conn.input?.listen(
        (data) {
          final chunk = utf8.decode(data, allowMalformed: true);
          pushIncoming(chunk);
        },
        onDone: () {
          set(ProvisionStatus.idle, message: 'Koneksi ditutup oleh perangkat');
        },
        onError: (e) {
          set(ProvisionStatus.idle, message: 'Kesalahan baca: $e');
        },
      );

      set(ProvisionStatus.connectedDevice, message: 'Terhubung ke perangkat.');
    } catch (e) {
      set(ProvisionStatus.idle, message: 'Gagal menghubungkan: $e');
    }
  }

  Future<void> disconnect() async {
    _wifiWaitTimer?.cancel();
    await _inputSub?.cancel();
    _inputSub = null;
    ssidController.clear();
    passController.clear();
    try {
      await _connection?.finish();
    } catch (_) {}
    _connection = null;
    set(ProvisionStatus.idle, message: 'Terputus.');
  }

  Future<void> sendProvision() async {
    if (!isConnected || isBusy) return;

    final ssid = ssidController.text.trim();
    final pass = passController.text.trim();
    if (ssid.isEmpty || pass.isEmpty) {
      _setMessage('Isi SSID dan Password terlebih dahulu.');
      return;
    }
    if (hasInvalidAngle(ssid) || hasInvalidAngle(pass)) {
      _setMessage('Hindari karakter < dan > pada SSID/PASS.');
      return;
    }

    try {
      await cancelDiscoverySafely();
      set(ProvisionStatus.provisioning, message: 'Mengirim kredensial Wi-Fi…');

      await writeLine('ssid:<$ssid>');
      await Future.delayed(const Duration(milliseconds: 120));
      await writeLine('pass:<$pass>');
      _setMessage('Menunggu status dari perangkat…');

      _wifiWaitTimer?.cancel();
      _wifiWaitTimer = Timer(const Duration(seconds: 20), () {
        if (_status == ProvisionStatus.provisioning) {
          set(ProvisionStatus.wifiFailed, message: 'Tidak ada respons dari perangkat.');
        }
      });
    } catch (e) {
      set(ProvisionStatus.wifiFailed, message: 'Gagal mengirim: $e');
    }
  }

  Future<String> assignDeviceIdOnSave() async {
    if (!isConnected) {
      throw Exception('Belum terhubung ke perangkat via Bluetooth.');
    }

    _setMessage('Memeriksa deviceId di perangkat…');
    final got = await cmdGetId();

    if (got != null && got.isNotEmpty) {
      _currentDeviceId = got;
      notifyListeners();
      _setMessage('deviceId terdeteksi: $got');
      await ensureDeviceRegisteredUseCase.call(deviceId: got);
      return got;
    }

    _setMessage('Mendaftarkan device baru…');
    final resId = await registerDeviceUseCase.call();
    final newId = resId.fold(
          (f) => throw Exception(f.message),
          (v) => v,
    );

    _setMessage('Menyetel deviceId ke ESP32…');
    final ok = await cmdSetId(newId);
    if (!ok) {
      throw Exception('Gagal set deviceId ke ESP32 (SET_ID_FAIL).');
    }

    _setMessage('Memverifikasi penyimpanan deviceId…');
    await _verifyDeviceIdApplied(newId);

    await ensureDeviceRegisteredUseCase.call(deviceId: newId);

    _currentDeviceId = newId;
    notifyListeners();
    _setMessage('deviceId disetel: $newId');
    return newId;
  }

  static const int _getIdMaxRetries = 3;

  Future<void> _sleep(int ms) => Future.delayed(Duration(milliseconds: ms));

  Future<String> _verifyDeviceIdApplied(String expected) async {
    var delayMs = 200;
    for (var attempt = 1; attempt <= _getIdMaxRetries; attempt++) {
      final got = await cmdGetId();
      if (got == expected) return got!;
      await _sleep(delayMs);
      delayMs *= 2;
    }
    throw Exception('Device belum menerapkan ID. Diharapkan: $expected');
  }

  Future<void> ensurePermissions() async {
    if (!Platform.isAndroid) return;

    final android = await DeviceInfoPlugin().androidInfo;
    final sdk = android.version.sdkInt;

    if (sdk >= 31) {
      final res = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();

      final failed = [Permission.bluetoothScan, Permission.bluetoothConnect]
          .any((x) => res[x] == null || res[x]!.isDenied || res[x]!.isPermanentlyDenied);

      if (failed) {
        throw Exception('Izin Bluetooth ditolak. Buka Settings > Apps > izin Bluetooth.');
      }
    } else {
      final res = await [
        Permission.bluetooth,
        Permission.location,
      ].request();
      final failed = res.values.any((s) => s.isDenied || s.isPermanentlyDenied);
      if (failed) throw Exception('Izin Bluetooth atau Location ditolak.');
    }
  }

  Future<void> cancelDiscoverySafely() async {
    try {
      await FlutterBluetoothSerial.instance.cancelDiscovery();
    } catch (_) {}
    await _discoverySub?.cancel();
    _discoverySub = null;
  }

  Future<bool> _ensureBtEnabled() async {
    final enabled = await FlutterBluetoothSerial.instance.isEnabled;
    if (enabled == true) return true;
    return (await FlutterBluetoothSerial.instance.requestEnable()) == true;
  }

  Future<List<BluetoothDiscoveryResult>> _discover({
    Duration timeout = const Duration(seconds: 6),
  }) async {
    final results = <BluetoothDiscoveryResult>[];
    try {
      final stream = FlutterBluetoothSerial.instance.startDiscovery();
      final completer = Completer<void>();
      _discoverySub = stream.listen((r) {
        final i = results.indexWhere((x) => x.device.address == r.device.address);
        if (i >= 0) {
          results[i] = r;
        } else {
          results.add(r);
        }
      }, onDone: () {
        if (!completer.isCompleted) completer.complete();
      }, onError: (_) {
        if (!completer.isCompleted) completer.complete();
      });

      await Future.any([completer.future, Future.delayed(timeout)]);
    } catch (_) {
      // ignore
    } finally {
      await cancelDiscoverySafely();
    }
    return results;
  }

  Future<BluetoothDevice?> pickDevice(BuildContext context) async {
    final bonded = await FlutterBluetoothSerial.instance.getBondedDevices();
    final discovered = await _discover();

    const preferredNames = ['Mbelys-IoT'];

    final map = <String, BluetoothDevice>{};
    for (final d in bonded) {
      map[d.address] = d;
    }
    for (final r in discovered) {
      map.putIfAbsent(r.device.address, () => r.device);
    }
    var devices = map.values.toList();

    devices.sort((a, b) {
      final an = (a.name ?? '').toLowerCase();
      final bn = (b.name ?? '').toLowerCase();
      final ap = preferredNames.any((p) => an.contains(p.toLowerCase())) ? 0 : 1;
      final bp = preferredNames.any((p) => bn.contains(p.toLowerCase())) ? 0 : 1;
      final byP = ap.compareTo(bp);
      if (byP != 0) return byP;
      return an.compareTo(bn);
    });

    if (devices.isEmpty) {
      _setMessage('Tidak ada perangkat ditemukan.');
      return null;
    }

    return showDialog<BluetoothDevice>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Pilih Perangkat Mbelys',
          style: const TextStyle(
            color: AppColors.color9,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        backgroundColor: AppColors.color2,
        content: Container(
          width: double.maxFinite,
          height: 360,
          color: AppColors.color2,
          child: ListView.separated(
            itemCount: devices.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (c, i) {
              final d = devices[i];
              return ListTile(
                leading: const Icon(Icons.bluetooth, color: AppColors.color1),
                title: Text(
                  d.name ?? '(unknown)',
                  style: const TextStyle(
                    color: AppColors.color9,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
                subtitle: Text(
                  d.address,
                  style: const TextStyle(
                    color: AppColors.color1,
                    fontFamily: "Mulish",
                  ),
                ),
                onTap: () => Navigator.pop(c, d),
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal'))],
      ),
    );
  }

  Future<void> writeLine(String line) async {
    final conn = _connection;
    if (conn == null || !conn.isConnected) throw Exception('Belum terhubung');
    conn.output.add(utf8.encode('$line\n'));
    await conn.output.allSent;
  }

  void pushIncoming(String chunk) {
    _lineBuf.write(chunk);
    String all = _lineBuf.toString();
    int idx;
    while ((idx = all.indexOf('\n')) >= 0) {
      final line = all.substring(0, idx).trim();
      if (line.isNotEmpty) handleLine(line);
      all = all.substring(idx + 1);
    }
    _lineBuf
      ..clear()
      ..write(all);
  }

  void handleLine(String line) {
    final up = line.toUpperCase();

    if (_okMarkers.any((k) => up.contains(k))) {
      _wifiWaitTimer?.cancel();
      set(ProvisionStatus.wifiConnected, message: 'Wi-Fi terhubung.');
      return;
    }
    if (_failMarkers.any((k) => up.contains(k))) {
      _wifiWaitTimer?.cancel();
      set(ProvisionStatus.wifiFailed, message: 'Wi-Fi gagal. Coba SSID/PASS lain.');
      return;
    }

    if (up == 'NO_ID') {
      _pendingGetId?.complete(null);
      _pendingGetId = null;
      return;
    }
    if (up.startsWith('ID:')) {
      final id = line.substring(3).trim(); // keep original case
      _pendingGetId?.complete(id.isEmpty ? null : id);
      _pendingGetId = null;
      return;
    }
    if (up == 'SET_ID_OK' || up == 'SET_ID_FAIL') {
      _pendingSetId?.complete(up == 'SET_ID_OK');
      _pendingSetId = null;
      return;
    }
  }

  Future<String?> cmdGetId({Duration timeout = const Duration(seconds: 4)}) async {
    final c = Completer<String?>();
    _pendingGetId = c;
    await writeLine('getid');
    try {
      return await c.future.timeout(timeout);
    } catch (_) {
      _pendingGetId = null;
      return null;
    }
  }

  Future<bool> cmdSetId(String id, {Duration timeout = const Duration(seconds: 4)}) async {
    final c = Completer<bool>();
    _pendingSetId = c;
    await writeLine('setid:$id');
    try {
      return await c.future.timeout(timeout);
    } catch (_) {
      _pendingSetId = null;
      return false;
    }
  }

  String? validateSSID(String? value) {
    if (value == null || value.isEmpty) return 'SSID tidak boleh kosong';
    return null;
  }

  String? validatePass(String? value) {
    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
    return null;
  }

  bool hasInvalidAngle(String s) => s.contains('<') || s.contains('>');

  void set(ProvisionStatus status, {String? message}) {
    _status = status;
    if (message != null) _message = message;
    notifyListeners();
  }

  void _setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  @override
  void dispose() {
    _wifiWaitTimer?.cancel();
    _inputSub?.cancel();
    _discoverySub?.cancel();
    _connection?.dispose();
    ssidController.dispose();
    passController.dispose();
    super.dispose();
  }
}
