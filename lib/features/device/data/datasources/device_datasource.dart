import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/device/data/models/device_model.dart';

abstract class DeviceDataSource {
  Future<String> registerDevice ();
  Future<void> registerDeviceWithId ({ required String deviceId });
  Future<DeviceModel> getDevice ({ required String deviceId });
  Future<void> reprovisionWifi ({ required String deviceId });
  Future<bool> isDeviceExists ({ required String deviceId });
  Future<void> ensureDeviceRegistered ({ required String deviceId });
}

class FirestoreDeviceDataSource implements DeviceDataSource {
  final FirebaseFirestore firestore;
  FirestoreDeviceDataSource ({ required this.firestore });

  CollectionReference<Map<String, dynamic>> get collection => firestore.collection("MsDevice");

  @override
  Future<String> registerDevice () async {
    final newDocRef = collection.doc();
    final newId = newDocRef.id;
    final newDevice = DeviceModel(
      deviceId: newId,
      createdAt: DateTime.now(),
      provisionedAt: DateTime.now(),
      provisionCount: 0,
      configVersion: 0
    );
    await newDocRef.set(newDevice.toJson());
    return newId;
  }

  @override
  Future<void> registerDeviceWithId ({ required String deviceId }) async {
    final docRef = collection.doc(deviceId);
    final snap = await docRef.get();
    if (snap.exists) return;
    await docRef.set({
      'deviceId': deviceId,
      'provisionedAt': FieldValue.serverTimestamp(),
      'provisionCount': FieldValue.increment(1),
    });
  }

  @override
  Future<DeviceModel> getDevice ({ required String deviceId }) async {
    final device = await collection.doc(deviceId).get();
    if (!device.exists || device.data() == null) {
      throw Exception("Perangkat tidak ditemukan!");
    }
    return DeviceModel.fromFirebase(device);
  }

  @override
  Future<void> reprovisionWifi ({ required String deviceId }) async {
    final device = await collection.doc(deviceId).get();
    if (!device.exists || device.data() == null) {
      throw Exception("Perangkat tidak ditemukan!");
    }
    await collection.doc(deviceId).update({
      'provisionedAt': FieldValue.serverTimestamp(),
      'provisionCount': FieldValue.increment(1),
    });
  }

  @override
  Future<bool> isDeviceExists ({ required String deviceId }) async {
    final device = await collection.doc(deviceId).get();
    return device.exists;
  }

  @override
  Future<void> ensureDeviceRegistered({required String deviceId}) async {
    final exists = await isDeviceExists(deviceId: deviceId);
    if (!exists) {
      await registerDeviceWithId(deviceId: deviceId);
    }
    await reprovisionWifi(deviceId: deviceId);
  }
}