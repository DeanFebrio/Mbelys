class DeviceEntity {
  final String deviceId;
  final DateTime createdAt;
  final DateTime provisionedAt;
  final int provisionCount;
  final int configVersion;

  DeviceEntity({
    required this.deviceId,
    required this.createdAt,
    required this.provisionedAt,
    required this.provisionCount,
    required this.configVersion
  });
}