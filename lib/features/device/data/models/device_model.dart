import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/device/domain/entities/device_entity.dart';

class DeviceModel extends DeviceEntity {
  DeviceModel({
    required super.deviceId,
    required super.createdAt,
    required super.provisionedAt,
    required super.provisionCount,
    required super.registerSource,
    required super.configVersion
  });

  factory DeviceModel.fromFirebase(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    DateTime? ts(dynamic v) => v is Timestamp ? v.toDate() : (v is DateTime ? v : null);

    return DeviceModel(
      deviceId: snapshot.id,
      createdAt: ts(data['createdAt']) ?? DateTime.now(),
      provisionedAt: ts(data['provisionedAt']) ?? DateTime.now(),
      registerSource: data['registerSource'] as String,
      provisionCount: data['provisionCount'] as int,
      configVersion: data['configVersion'] as int
    );
  }

  DeviceModel copyWith ({
    String? deviceId,
    DateTime? createdAt,
    DateTime? provisionedAt,
    int? provisionCount,
    String? registerSource,
    int? configVersion,
  }) {
    return DeviceModel(
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      provisionedAt: provisionedAt ?? this.provisionedAt,
      provisionCount: provisionCount ?? this.provisionCount,
      registerSource: registerSource ?? this.registerSource,
      configVersion: configVersion ?? this.configVersion
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'createdAt': Timestamp.fromDate(createdAt),
      'provisionedAt': Timestamp.fromDate(provisionedAt),
      'provisionCount': provisionCount,
      'registerSource': registerSource,
      'configVersion': configVersion
    };
  }
}