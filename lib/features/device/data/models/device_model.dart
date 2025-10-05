import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/device/domain/entities/device_entity.dart';

class DeviceModel extends DeviceEntity {
  DeviceModel({
    required super.deviceId,
    required super.createdAt,
    required super.provisionedAt,
    required super.provisionCount,
    required super.configVersion
  });

  factory DeviceModel.fromFirebase(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    DateTime toDate (dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return DateTime.now();
    }

    return DeviceModel(
      deviceId: snapshot.id,
      createdAt: toDate(data['createdAt']),
      provisionedAt: toDate(data['provisionedAt']),
      provisionCount: data['provisionCount'] as int,
      configVersion: data['configVersion'] as int
    );
  }

  DeviceModel copyWith ({
    String? deviceId,
    DateTime? createdAt,
    DateTime? provisionedAt,
    int? provisionCount,
    int? configVersion,
  }) {
    return DeviceModel(
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      provisionedAt: provisionedAt ?? this.provisionedAt,
      provisionCount: provisionCount ?? this.provisionCount,
      configVersion: configVersion ?? this.configVersion
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'createdAt': Timestamp.fromDate(createdAt),
      'provisionedAt': Timestamp.fromDate(provisionedAt),
      'provisionCount': provisionCount,
      'configVersion': configVersion
    };
  }
}