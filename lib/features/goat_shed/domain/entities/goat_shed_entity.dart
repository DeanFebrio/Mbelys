class GoatShedEntity {
  final String id;
  final String name;
  final int total;
  final String location;
  final String ownerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // final String image;
  // final bool isStressed;
  // final bool isFertile;
  // final String description;
  // final String suggestion;

  GoatShedEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.total,
    required this.ownerId,
    this.createdAt,
    this.updatedAt
  });
}