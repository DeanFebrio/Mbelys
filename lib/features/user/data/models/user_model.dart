
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel ({
    required super.uid,
    required super.email,
    required super.name,
    required super.phone,
    super.pendingEmail,
    super.emailChangeStatus,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromFirebase(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snap.id,
      email: data['email'],
      name: data['name'],
      phone: data['phone'],
      pendingEmail: data['pendingEmail'],
      emailChangeStatus: data['emailChangeStatus'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'pendingEmail': pendingEmail,
      'emailChangeStatus': emailChangeStatus,
      'createdAt': Timestamp.fromDate(createdAt!.toUtc()),
      'updatedAt': Timestamp.fromDate(updatedAt!.toUtc()),
    };
  }
}