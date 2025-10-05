import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';

class GoatShedModel extends GoatShedEntity {
  GoatShedModel({
    required super.shedId,
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
      userId: data['userId'],
      deviceId: data['deviceId'],
      shedStatus: data['shedStatus'],
      shedName: data['shedName'],
      shedImageUrl: data['shedImageUrl'],
      shedLocation: data['shedLocation'],
      totalGoats: (data['totalGoats'] as num).toInt(),
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
      'analyzedAt': analyzedAt != null ? Timestamp.fromDate(analyzedAt!) : null,
    };
  }

  GoatShedEntity toEntity () {
    return GoatShedEntity(
        shedId: shedId,
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