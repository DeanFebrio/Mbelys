import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';

class GoatShedModel extends GoatShedEntity {
  GoatShedModel({
    required super.shedId,
    required super.shedName,
    required super.shedLocation,
    required super.totalGoats,
    required super.ownerId,
    super.shedImageUrl,
    super.createdAt,
    super.updatedAt,
  });

  GoatShedModel copyWith ({
    String? shedId,
    String? shedName,
    String? shedLocation,
    int? totalGoats,
    String? ownerId,
    String? shedImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GoatShedModel(
      shedId: shedId ?? this.shedId,
      shedName: shedName ?? this.shedName,
      shedLocation: shedLocation ?? this.shedLocation,
      totalGoats: totalGoats ?? this.totalGoats,
      ownerId: ownerId ?? this.ownerId,
      shedImageUrl: shedImageUrl ?? this.shedImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory GoatShedModel.fromFirebase(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return GoatShedModel(
      shedId: snap.id,
      shedName: data['shedName'],
      shedLocation: data['shedLocation'],
      totalGoats: data['totalGoats'],
      ownerId: data['ownerId'],
      shedImageUrl: data['shedImageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shedId': shedId,
      'shedName': shedName,
      'shedLocation': shedLocation,
      'totalGoats': totalGoats,
      'ownerId': ownerId,
      'shedImageUrl': shedImageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}