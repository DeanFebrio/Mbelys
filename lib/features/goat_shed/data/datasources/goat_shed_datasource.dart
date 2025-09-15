import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mbelys/features/goat_shed/data/models/goat_shed_model.dart';
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';

abstract class GoatShedDataSource {
  Future<void> createGoatShed ({required GoatShedModel goatShed, required File imageFile });
  Stream<List<GoatShedModel>> getGoatShedList ({ required String ownerId });
  Stream<GoatShedModel> getGoatShedDetail ({required String shedId});

  Future<void> updateGoatShed ({ required String shedId, required Map<String, dynamic> updates });
  Future<void> changeGoatShedImage ({ required String shedId, required File newImageFile });
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
    final newDocRef = firestore.collection("goat_shed").doc();
    final newId = newDocRef.id;

    final imageUrl = await uploadShedImage(
        shedId: newId,
        ownerId: goatShed.ownerId,
        imageFile: imageFile
    );
    final newShed = goatShed.copyWith(shedId: newId, shedImageUrl: imageUrl);
    return await newDocRef.set(newShed.toJson());
  }

  @override
  Stream<List<GoatShedModel>> getGoatShedList ({ required String ownerId }) {
    final snapshot = firestore
        .collection("goat_shed")
        .where("ownerId", isEqualTo: ownerId)
        .snapshots();
    return snapshot.map((snapshot) {
      return snapshot.docs
          .map((doc) => GoatShedModel.fromFirebase(doc))
          .toList();
    });
  }

  @override
  Stream<GoatShedModel> getGoatShedDetail ({ required String shedId }) {
    final snapshot = firestore
        .collection("goat_shed")
        .doc(shedId)
        .snapshots();
    return snapshot.map((snap) {
      if (!snap.exists) {
        throw StateError("Kandang tidak ditemukan!");
      }
      return GoatShedModel.fromFirebase(snap);
    });
  }

  @override
  Future<void> updateGoatShed ({ required String shedId, required Map<String, dynamic> updates }) async {
    updates['updatedAt'] = FieldValue.serverTimestamp();
    return await firestore.collection("goat_shed").doc(shedId).update(updates);
  }

  @override
  Future<void> changeGoatShedImage ({ required String shedId, required File newImageFile }) async {
    final shedRef = await firestore.collection("goat_shed").doc(shedId).get();

    if (!shedRef.exists) {
      throw Exception("Kandang dengan ID $shedId tidak ditemukan!");
    }

    final oldData = shedRef.data()!;
    final oldImageUrl = oldData['shedImageUrl'] as String?;
    final ownerId = oldData['ownerId'] as String;

    final newImageUrl = await uploadShedImage(shedId: shedId, ownerId: ownerId, imageFile: newImageFile);

    await updateGoatShed(shedId: shedId, updates: { "shedImageUrl" : newImageUrl });

    if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
      await deleteImage(imageUrl: oldImageUrl);
    }
  }

  Future<String> uploadShedImage ({ required String shedId, required String ownerId, required File imageFile }) async {
    final fileExtension = p.extension(imageFile.path);
    final mimeType = lookupMimeType(imageFile.path) ?? "image/jpeg";

    if (!mimeType.startsWith("image/")) throw Exception("File bukan gambar yang valid!");

    final fileName = "shed_${shedId}_${DateTime.now().microsecondsSinceEpoch}$fileExtension";
    final storagePath = 'goat_shed_picture/$ownerId/$fileName';
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

  Future<void> deleteImage ({ required String imageUrl }) async {
    return await storage.refFromURL(imageUrl).delete();
  }
}

