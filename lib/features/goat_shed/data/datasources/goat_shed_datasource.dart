import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mbelys/features/goat_shed/data/models/goat_shed_model.dart';

abstract class GoatShedDataSource {
  Future<void> createGoatShed ({required GoatShedModel goatShed, required File imageFile });
  Stream<List<GoatShedModel>> getGoatShedList ({ required String ownerId });
  Stream<GoatShedModel> getGoatShedDetail ({required String shedId});
}

class FirestoreGoatShedDataSource implements GoatShedDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  FirestoreGoatShedDataSource({
    required this.firestore,
    required this.storage
  });

  @override
  Future<void> createGoatShed ({ required GoatShedModel goatShed, required File imageFile }) async {
    try {
      final newDocRef = firestore.collection("goat_shed").doc();

      String imageUrl = '';
      final storagePath = 'goat_shed_picture/${goatShed.ownerId}/${newDocRef.id}';
      final storageRef = storage.ref(storagePath);
      await storageRef.putFile(
          imageFile,
          SettableMetadata(
              contentType: 'image/jpg',
              cacheControl: 'public, max-age=3600'
          )
      );
      imageUrl = await storageRef.getDownloadURL();

      final newDoc = firestore.collection("goat_shed").doc();
      final newId = newDoc.id;
      final newShed = goatShed.copyWith(shedId: newId, shedImageUrl: imageUrl);
      return await newDoc.set(newShed.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<GoatShedModel>> getGoatShedList ({ required String ownerId }) {
    try {
      final snapshot = firestore
          .collection("goat_shed")
          .where("ownerId", isEqualTo: ownerId)
          .snapshots();
      return snapshot.map((snapshot) {
        return snapshot.docs
            .map((doc) => GoatShedModel.fromFirebase(doc))
            .toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<GoatShedModel> getGoatShedDetail ({ required String shedId }) {
    try {
      final snapshot = firestore
          .collection("goat_shed")
          .doc(shedId)
          .snapshots();
      return snapshot.map((snap) {
        if (!snap.exists) {
          throw Exception("Kandang tidak ditemukan!");
        }
        return GoatShedModel.fromFirebase(snap);
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}

