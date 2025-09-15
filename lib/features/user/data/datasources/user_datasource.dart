import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mbelys/features/user/data/models/user_model.dart';

abstract class UserDataSource {
  Future<void> createUser ({ required UserModel user });
  Future<UserModel> getUserData ({ required String uid });
  Stream<UserModel> watchUserData ({required String uid});

  Future<void> changeName ({ required String name, required String uid });
  Future<void> changePhone ({ required String phone, required String uid });
  Future<void> changePhoto ({ required String uid, required File file});
}

class FirestoreUserDataSource implements UserDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  FirestoreUserDataSource({
    required this.firestore,
    required this.storage
  });

  @override
  Future<void> createUser({ required UserModel user }) async {
    return await firestore.collection("users").doc(user.id).set(
        user.toJson(), SetOptions(merge: true)
    );
  }

  @override
  Future<UserModel> getUserData ({ required String uid }) async {
    try {
      final snap = await firestore.collection("users").doc(uid).get();
      if (!snap.exists ||  snap.data() == null) {
        throw Exception("Pengguna tidak ditemukan!");
      }
      return UserModel.fromFirebase(snap);
    } catch (e) {
      throw Exception(e);
    }
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
    return firestore.collection("users").doc(uid).update({
      "name": name,
      "updatedAt": FieldValue.serverTimestamp()
    });
  }

  @override
  Future<void> changePhone ({ required String phone, required String uid }) async {
   return firestore.collection("users").doc(uid).update({
     "phone": phone,
     "updatedAt": FieldValue.serverTimestamp()
   });
  }

  @override
  Future<void> changePhoto ({ required String uid, required File file }) async {
    try {
      final userRef = firestore.collection("users").doc(uid);
      String? oldPath;

      final snap = await userRef.get();
      oldPath = snap.data()?['photoUrl'] as String?;

      final fileName = 'profile_${DateTime.now().microsecondsSinceEpoch}.jpg';
      final path = 'user_photo_profile/$uid/$fileName';
      final ref = storage.ref(path);

      await ref.putFile(
        file,
        SettableMetadata(
          contentType: 'image/jpg',
          cacheControl: 'public, max-age=3600'
        )
      );

      final url = await ref.getDownloadURL();
      await userRef.set({
        'photoUrl': url,
        'updatedAt': DateTime.now()
      }, SetOptions(merge: true));

      if (oldPath != null) {
        await storage.ref(oldPath).delete().catchError((_) {});
      }
    } catch (e) {
      throw Exception("Gagal mengubah foto profil");
    }

  }
}