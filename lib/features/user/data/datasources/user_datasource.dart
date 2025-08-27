import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/user/data/models/user_model.dart';

abstract class UserDataSource {
  Future<void> createUser ({required UserModel user});
  Future<UserModel> getUserProfile ({required String uid});
}

class FirestoreUserDataSource implements UserDataSource {
  final FirebaseFirestore firestore = sl<FirebaseFirestore>();

  @override
  Future<void> createUser({required UserModel user}) async {
    return await firestore.collection("users").doc(user.uid).set(user.toJson());
  }

  @override
  Future<UserModel> getUserProfile ({required String uid}) async {
    final snap = await firestore.collection("users").doc(uid).get();
    if (!snap.exists) {
      throw Exception("Pengguna tidak ditemukan!");
    }
    return UserModel.fromFirebase(snap);
  }
}