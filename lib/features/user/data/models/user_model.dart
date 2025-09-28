
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel ({
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
    required super.email,
    required super.name,
    required super.phoneNumber,
    super.userPhotoUrl
  });

  factory UserModel.fromFirebase(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;

    DateTime toDate (dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return DateTime.now();
    }

    return UserModel(
      userId: snap.id,
      email: (data['email'] as String?) ?? "",
      createdAt: toDate(data['createdAt']),
      updatedAt: toDate(data['updatedAt']),
      name: (data['name'] as String?) ?? "",
      phoneNumber: (data['phoneNumber'] as String?) ?? "",
      userPhotoUrl: (data['userPhotoUrl'] as String?) ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'userPhotoUrl': userPhotoUrl,
    };
  }
}