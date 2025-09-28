import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mbelys/features/user/data/models/user_model.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

abstract class UserDataSource {
  Future<void> createUser ({ required UserModel user });
  Future<UserModel> getUserData ({ required String userId });
  Stream<UserModel> watchUserData ({ required String userId });

  Future<void> updateUserData ({ required String userId, required Map<String, dynamic> updates });
  Future<void> changeUserPhoto ({ required String userId, required File imageFile });
}

class FirestoreUserDataSource implements UserDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  FirestoreUserDataSource({
    required this.firestore,
    required this.storage
  });

  CollectionReference<Map<String, dynamic>> get collection => firestore.collection("MsUser");

  @override
  Future<void> createUser({ required UserModel user }) async {
    return await collection.doc(user.userId).set(
        user.toJson(), SetOptions(merge: true)
    );
  }

  @override
  Future<UserModel> getUserData ({ required String userId }) async {
    try {
      final snap = await collection.doc(userId).get();
      if (!snap.exists ||  snap.data() == null) {
        throw Exception("Pengguna tidak ditemukan!");
      }
      return UserModel.fromFirebase(snap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<UserModel> watchUserData ({ required String userId }) {
    final docRef = collection.doc(userId);
    return docRef.snapshots().map((snap) {
      if (!snap.exists) {
        throw Exception("Pengguna tidak ditemukan!");
      }
      return UserModel.fromFirebase(snap);
    });
  }

  @override
  Future<void> updateUserData ({ required String userId, required Map<String, dynamic> updates }) async {
    updates['updatedAt'] = FieldValue.serverTimestamp();
    return await collection.doc(userId).update(updates);
  }

  @override
  Future<void> changeUserPhoto ({ required String userId, required File imageFile }) async {
    try {
      final userRef = collection.doc(userId);
      String? oldPath;

      final snap = await userRef.get();
      oldPath = snap.data()?['userPhotoUrl'] as String?;

      final url = await uploadUserPhoto(userId: userId, imageFile: imageFile);

      await userRef.set({
        'userPhotoUrl': url,
        'updatedAt': FieldValue.serverTimestamp()
      }, SetOptions(merge: true));

      if (oldPath != null) {
        try {
          await storage.refFromURL(oldPath).delete();
        } catch (_) { }
      }
    } catch (e) {
      throw Exception("Gagal mengubah foto profil");
    }
  }

  Future<String> uploadUserPhoto ({ required String userId, required File imageFile }) async {
    final fileExtension = p.extension(imageFile.path);
    final mimeType = lookupMimeType(imageFile.path) ?? "image/jpeg";

    if (!mimeType.startsWith("image/")) throw Exception("File bukan gambar yang valid!");

    final fileName = "userPhoto_${DateTime.now().microsecondsSinceEpoch}$fileExtension";
    final storagePath = 'user_photo/$userId/$fileName';
    final storageRef = storage.ref(storagePath);

    await storageRef.putFile(
      imageFile,
      SettableMetadata(
        contentType: mimeType,
        cacheControl: 'public, max-age=3600'
      )
    );
    return await storageRef.getDownloadURL();
  }
}