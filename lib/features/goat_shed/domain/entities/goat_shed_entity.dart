class GoatShedEntity {
  final String shedId;
  final String userId;
  final String deviceId;
  final String shedStatus;
  final String shedName;
  final String shedImageUrl;
  final String shedLocation;
  final int totalGoats;
  final String? stressStatus;
  final String? reproductiveStatus;
  final String? recommendation;
  final String? explanation;
  final DateTime? analyzedAt;

  GoatShedEntity({
    required this.shedId,
    required this.userId,
    required this.deviceId,
    required this.shedStatus,
    required this.shedName,
    required this.shedImageUrl,
    required this.shedLocation,
    required this.totalGoats,
    this.stressStatus,
    this.reproductiveStatus,
    this.recommendation,
    this.explanation,
    this.analyzedAt
  });
}