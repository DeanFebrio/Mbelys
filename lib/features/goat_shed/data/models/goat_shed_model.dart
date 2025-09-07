import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';

class GoatShedModel extends GoatShedEntity {
  GoatShedModel({
    super.id,
    required super.name,
    required super.location,
    required super.total,
    required super.ownerId,
    super.createdAt,
    super.updatedAt,
  });

  GoatShedModel copyWith ({
    String? id,
    String? name,
    String? location,
    int? total,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GoatShedModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      total: total ?? this.total,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory GoatShedModel.fromFirebase(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return GoatShedModel(
      id: snap.id,
      name: data['name'],
      location: data['location'],
      total: data['total'],
      ownerId: data['ownerId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'total': total,
      'ownerId': ownerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}