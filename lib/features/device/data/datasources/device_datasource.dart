import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/device/data/models/device_model.dart';

abstract class DeviceDataSource {
  Future<String> registerDevice ();
  Future<DeviceModel> getDevice ({ required String deviceId });
  Future<void> reprovisionWifi ({ required String deviceId });
  Future<bool> isDeviceExists ({ required String deviceId });
}

class FirestoreDeviceDataSource implements DeviceDataSource {
  final FirebaseFirestore firestore;
  FirestoreDeviceDataSource ({ required this.firestore });

  CollectionReference<Map<String, dynamic>> get collection => firestore.collection("MsDevice");

  @override
  Future<String> registerDevice () async {
    try {
      final newDocRef = collection.doc();
      final newId = newDocRef.id;
      final newDevice = DeviceModel(
        deviceId: newId,
        createdAt: DateTime.now(),
        provisionedAt: DateTime.now(),
        configVersion: 0
      );
      await newDocRef.set(newDevice.toJson());
      return newId;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeviceModel> getDevice ({ required String deviceId }) async {
    try {
      final device = await collection.doc(deviceId).get();
      if (!device.exists || device.data() == null) {
        throw Exception("Perangkat tidak ditemukan!");
      }
      return DeviceModel.fromFirebase(device);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> reprovisionWifi ({ required String deviceId }) async {
    try {
      final device = await collection.doc(deviceId).get();
      if (!device.exists || device.data() == null) {
        throw Exception("Perangkat tidak ditemukan!");
      }
      await collection.doc(deviceId).update({
        'provisionedAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isDeviceExists ({ required String deviceId }) async {
    try {
      final device = await collection.doc(deviceId).get();
      return device.exists;
    } catch (e) {
      rethrow;
    }
  }
}