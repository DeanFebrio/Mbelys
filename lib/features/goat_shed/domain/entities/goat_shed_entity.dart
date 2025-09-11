class GoatShedEntity {
  final String shedId;
  final String shedName;
  final int totalGoats;
  final String shedLocation;
  final String ownerId;
  final String? shedImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // final bool isStressed;
  // final bool isFertile;
  // final String description;
  // final String suggestion;

  GoatShedEntity({
    required this.shedId,
    required this.shedName,
    required this.shedLocation,
    required this.totalGoats,
    required this.ownerId,
    this.shedImageUrl,
    this.createdAt,
    this.updatedAt
  });
}