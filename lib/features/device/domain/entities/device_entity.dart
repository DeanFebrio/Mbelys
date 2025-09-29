class DeviceEntity {
  final String deviceId;
  final DateTime createdAt;
  final DateTime provisionedAt;
  final int configVersion;

  DeviceEntity({
    required this.deviceId,
    required this.createdAt,
    required this.provisionedAt,
    required this.configVersion
  });
}