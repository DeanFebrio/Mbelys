
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel ({
    required super.id,
    required super.email,
    required super.name,
    required super.phone,
    super.photoUrl,
    super.pendingEmail,
    super.emailChangeStatus,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromFirebase(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return UserModel(
      id: snap.id,
      email: (data['email'] as String?) ?? "",
      name: (data['name'] as String?) ?? "",
      phone: (data['phone'] as String?) ?? "",
      photoUrl: data['photoUrl'] as String?,
      pendingEmail: data['pendingEmail'] as String?,
      emailChangeStatus: data['emailChangeStatus'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'photoUrl': photoUrl,
      'pendingEmail': pendingEmail,
      'emailChangeStatus': emailChangeStatus,
      'createdAt': createdAt ?? DateTime.now(),
      'updatedAt': updatedAt ?? DateTime.now(),
    };
  }
}