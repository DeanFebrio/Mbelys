import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

enum ProvisionStatus {
  idle,
  connectingDevice,
  connectedDevice,
  provisioning,
  wifiConnected,
  wifiFailed
}

class ProvisionViewModel extends ChangeNotifier {
  ProvisionStatus _status = ProvisionStatus.idle;
  ProvisionStatus get status => _status;

  bool get isConnected => _connection?.isConnected == true;
  bool get isBusy =>
  _status == ProvisionStatus.connectingDevice || _status == ProvisionStatus.provisioning;

  String _message = "";
  String get message => _message;

  BluetoothConnection? _connection;
  StreamSubscription<Uint8List>? _inputSub;
  StreamSubscription<BluetoothDiscoveryResult>? _discoverySub;

  Timer? _wifiWaitTimer;

  final ssidController = TextEditingController();
  final passController = TextEditingController();

  static const _okMarkers = ["WIFI_OK", "WIFI CONNECTED", "CONNECTED TO WIFI", "IP:"];
  static const _failMarkers = ["WIFI_FAIL", "FAIL", "WRONG PASSWORD", "NO SSID", "WIFI DISCONNECTED"];

  void set (ProvisionStatus status, {String? message}){
    _status = status;
    if (message != null) _message = message;
    notifyListeners();
  }

  void setMessage (String message) {
    _message = message;
    notifyListeners();
  }

  Future<void> _ensurePermissions() async {
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

  Future<void> _cancelDiscoverySafely() async {
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

  Future<List<BluetoothDiscoveryResult>> _discover({Duration timeout = const Duration(seconds: 6)}) async {
    final results = <BluetoothDiscoveryResult>[];
    try {
      final stream = FlutterBluetoothSerial.instance.startDiscovery();
      _discoverySub = stream.listen((r) {
        final i = results.indexWhere((x) => x.device.address == r.device.address);
        if (i >= 0) {
          results[i] = r;
        } else {
          results.add(r);
        }
      });
      await Future.any([_discoverySub!.asFuture<void>(), Future.delayed(timeout)]);
    } catch (_) {
    } finally {
      await _cancelDiscoverySafely();
    }
    return results;
  }

  Future<BluetoothDevice?> pickDevice(BuildContext context) async {
    final bonded = await FlutterBluetoothSerial.instance.getBondedDevices();
    final discovered = await _discover();

    const preferredNames = ['ESP32-BT-WIFI-CONTROLLER', 'ESP32', 'ESP32 DevKit'];

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
      setMessage ('Tidak ada perangkat ditemukan.');
      return null;
    }

    return showDialog<BluetoothDevice>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Pilih Perangkat ESP32',
          style: TextStyle(
            color: AppColors.color9,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins"
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
                leading: const Icon(
                  Icons.bluetooth,
                  color: AppColors.color1
                ),
                title: Text(
                  d.name ?? '(unknown)',
                  style: TextStyle(
                    color: AppColors.color9,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins"
                  ),
                ),
                subtitle: Text(
                  d.address,
                  style: TextStyle(
                    color: AppColors.color1,
                    fontFamily: "Mulish"
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

  Future<void> connect(BuildContext context) async {
    if (isBusy || isConnected) return;
    try {
      set (ProvisionStatus.connectingDevice, message: 'Menghubungkan ke perangkat...');
      await _ensurePermissions();
      await _cancelDiscoverySafely();
      if (!await _ensureBtEnabled()) {
        set (ProvisionStatus.idle, message: 'Bluetooth tidak aktif.');
        return;
      }

      final device = await pickDevice(context);
      if (device == null) {
        set (ProvisionStatus.idle, message: 'Dibatalkan.');
        return;
      }

      setMessage ('Menghubungkan ke ${device.name ?? device.address} ...');
      final conn = await BluetoothConnection.toAddress(device.address);
      _connection = conn;

      await _inputSub?.cancel();
      _inputSub = conn.input?.listen(
            (data) {
          final text = utf8.decode(data, allowMalformed: true);
          _handleIncoming(text);
        },
        onDone: () {
          set (ProvisionStatus.idle, message: 'Koneksi ditutup oleh perangkat');
        },
        onError: (e) {
          set (ProvisionStatus.idle, message: 'Kesalahan baca: $e');
        },
      );

      set (ProvisionStatus.connectedDevice, message: 'Terhubung ke perangkat.');
    } catch (e) {
      set (ProvisionStatus.idle, message: 'Gagal menghubungkan: $e');
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
    set (ProvisionStatus.idle, message: 'Terputus.');
  }

  bool _hasInvalidAngle(String s) => s.contains('<') || s.contains('>');

  Future<void> _writeLine(String line) async {
    final conn = _connection;
    if (conn == null || !conn.isConnected) throw Exception('Belum terhubung');
    conn.output.add(utf8.encode('$line\n'));
    await conn.output.allSent;
  }

  Future<void> sendProvision( ) async {
    if (!isConnected || isBusy) return;

    final ssid = ssidController.text.trim();
    final pass = passController.text.trim();
    if (ssid.isEmpty || pass.isEmpty) {
      setMessage ('Isi SSID dan Password terlebih dahulu.');
      return;
    }
    if (_hasInvalidAngle(ssid) || _hasInvalidAngle(pass)) {
      setMessage ('Hindari karakter < dan > pada SSID/PASS.');
      return;
    }

    try {
      await _cancelDiscoverySafely();
      set (ProvisionStatus.provisioning, message: 'Mengirim kredensial Wi-Fi...');

      await _writeLine('ssid:<$ssid>');
      await Future.delayed(const Duration(milliseconds: 120));
      await _writeLine('pass:<$pass>');
      setMessage ('Menunggu status dari perangkat...');

      _wifiWaitTimer?.cancel();
      _wifiWaitTimer = Timer(const Duration(seconds: 20), () {
        if (_status == ProvisionStatus.provisioning) {
          set (ProvisionStatus.wifiFailed, message: 'Tidak ada respons dari perangkat.');
        }
      });
    } catch (e) {
      set (ProvisionStatus.wifiFailed, message: 'Gagal mengirim: $e');
    }
  }

  void _handleIncoming(String raw) {
    final text = raw.toUpperCase();
    if (_okMarkers.any((k) => text.contains(k))) {
      _wifiWaitTimer?.cancel();
      set (ProvisionStatus.wifiConnected, message: 'Wi-Fi terhubung.');
      return;
    }
    if (_failMarkers.any((k) => text.contains(k))) {
      _wifiWaitTimer?.cancel();
      set (ProvisionStatus.wifiFailed, message: 'Wi-Fi gagal. Coba SSID/PASS lain.');
      return;
    }
  }

  String? validateSSID(String? value) {
    if (value == null || value.isEmpty) {
      return 'SSID tidak boleh kosong';
    }
    return null;
  }

  String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    return null;
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