import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';

class GoatShedModel extends GoatShedEntity {
  GoatShedModel({
    required super.shedId,
    required super.createdAt,
    required super.updatedAt,
    required super.userId,
    required super.deviceId,
    required super.shedStatus,
    required super.shedName,
    required super.shedImageUrl,
    required super.shedLocation,
    required super.totalGoats,
    super.stressStatus,
    super.reproductiveStatus,
    super.recommendation,
    super.explanation,
    super.analyzedAt
  });

  GoatShedModel copyWith ({
    String? shedId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    String? deviceId,
    String? shedStatus,
    String? shedName,
    String? shedImageUrl,
    String? shedLocation,
    int? totalGoats,
    String? stressStatus,
    String? reproductiveStatus,
    String? recommendation,
    String? explanation,
    DateTime? analyzedAt
  }) {
    return GoatShedModel(
      shedId: shedId ?? this.shedId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      shedStatus: shedStatus ?? this.shedStatus,
      shedName: shedName ?? this.shedName,
      shedImageUrl: shedImageUrl ?? this.shedImageUrl,
      shedLocation: shedLocation ?? this.shedLocation,
      totalGoats: totalGoats ?? this.totalGoats,
      stressStatus: stressStatus ?? this.stressStatus,
      reproductiveStatus: reproductiveStatus ?? this.reproductiveStatus,
      recommendation: recommendation ?? this.recommendation,
      explanation: explanation ?? this.explanation,
      analyzedAt: analyzedAt ?? this.analyzedAt
    );
  }

  factory GoatShedModel.fromFirebase(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;

    DateTime toDate (dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return DateTime.now();
    }

    DateTime? toDateOrNull (dynamic value) {
      if (value == null) return null;
      return toDate(value);
    }

    return GoatShedModel(
      shedId: snap.id,
      createdAt: toDate(data['createdAt']),
      updatedAt: toDate(data['updatedAt']),
      userId: data['userId'],
      deviceId: data['deviceId'],
      shedStatus: data['shedStatus'],
      shedName: data['shedName'],
      shedImageUrl: data['shedImageUrl'],
      shedLocation: data['shedLocation'],
      totalGoats: data['totalGoats'],
      stressStatus: data['stressStatus'],
      reproductiveStatus: data['reproductiveStatus'],
      recommendation: data['recommendation'],
      explanation: data['explanation'],
      analyzedAt: toDateOrNull(data['analyzedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shedId': shedId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'userId': userId,
      'deviceId': deviceId,
      'shedStatus': shedStatus,
      'shedName': shedName,
      'shedImageUrl': shedImageUrl,
      'shedLocation': shedLocation,
      'totalGoats': totalGoats,
      'stressStatus': stressStatus,
      'reproductiveStatus': reproductiveStatus,
      'recommendation': recommendation,
      'explanation': explanation,
      'analyzedAt': analyzedAt,
    };
  }

  GoatShedEntity toEntity () {
    return GoatShedEntity(
        shedId: shedId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userId: userId,
        deviceId: deviceId,
        shedStatus: shedStatus,
        shedName: shedName,
        shedImageUrl: shedImageUrl,
        shedLocation: shedLocation,
        totalGoats: totalGoats,
        stressStatus: stressStatus,
        reproductiveStatus: reproductiveStatus,
        recommendation: recommendation,
        explanation: explanation,
        analyzedAt: analyzedAt
    );
  }
}