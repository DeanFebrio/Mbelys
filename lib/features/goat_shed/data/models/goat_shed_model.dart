import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';

class GoatShedModel extends GoatShedEntity {
  GoatShedModel({
    required super.id,
    required super.name,
    required super.location,
    required super.total,
    required super.ownerId,
  });

  GoatShedModel copyWith ({
    String? id,
    String? name,
    String? location,
    int? total,
    String? ownerId,
  }) {
    return GoatShedModel(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
        total: total ?? this.total,
        ownerId: ownerId ?? this.ownerId
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'total': total,
      'ownerId': ownerId,
    };
  }
}