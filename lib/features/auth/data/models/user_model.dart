  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/user/domain/entities/user_entity.dart';

  class UserModel extends UserEntity {
    UserModel ({
    required super.uid,
    required super.email,
    required super.name,
    required super.phone,
    });

    factory UserModel.fromFirebase(DocumentSnapshot snap){
      final data = snap.data() as Map<String, dynamic>;

      return UserModel(
          uid: snap.id,
          email: data['email'] ?? "",
          name: data['name'] ?? "",
          phone: data['phone'] ?? "",
      );
    }
  }