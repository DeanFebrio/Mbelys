import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/user/data/models/user_model.dart';

abstract class UserDataSource {
  Future<void> createUser ({ required UserModel user });
  Future<UserModel> getUserData ({ required String uid });
  Stream<UserModel> watchUserData ({required String uid});

  Future<void> changeName ({ required String name, required String uid });
  Future<void> changePhone ({ required String phone, required String uid });
}

class FirestoreUserDataSource implements UserDataSource {
  final FirebaseFirestore firestore;
  FirestoreUserDataSource({ required this.firestore });

  @override
  Future<void> createUser({ required UserModel user }) async {
    return await firestore.collection("users").doc(user.uid).set(
        user.toJson(), SetOptions(merge: true)
    );
  }

  @override
  Future<UserModel> getUserData ({ required String uid }) async {
    final snap = await firestore.collection("users").doc(uid).get();
    if (!snap.exists) {
      throw Exception("Pengguna tidak ditemukan!");
    }
    return UserModel.fromFirebase(snap);
  }

  @override
  Stream<UserModel> watchUserData ({ required String uid }) {
    final docRef = firestore.collection("users").doc(uid);
    return docRef.snapshots().map((snap) {
      if (!snap.exists) {
        throw Exception("Pengguna tidak ditemukan!");
      }
      return UserModel.fromFirebase(snap);
    });
  }

  @override
  Future<void> changeName ({ required String name, required String uid }) async {
    return firestore.collection("users").doc(uid).update({"name": name});
  }

  @override
  Future<void> changePhone ({ required String phone, required String uid }) async {
   return firestore.collection("users").doc(uid).update({"phone": phone});
  }
}