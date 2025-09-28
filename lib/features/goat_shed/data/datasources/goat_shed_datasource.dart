import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mbelys/features/goat_shed/data/models/goat_shed_model.dart';
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';

abstract class GoatShedDataSource {
  Future<void> createGoatShed ({ required GoatShedModel goatShed, required File imageFile });
  Stream<List<GoatShedModel>> getGoatShedList ({ required String userId });
  Stream<GoatShedModel> getGoatShedDetail ({ required String shedId });

  Future<void> updateGoatShed ({ required String shedId, required Map<String, dynamic> updates });
  Future<void> changeGoatShedImage ({ required String shedId, required File imageFile });
}

class FirestoreGoatShedDataSource implements GoatShedDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  FirestoreGoatShedDataSource({
    required this.firestore,
    required this.storage
  });

  CollectionReference<Map<String, dynamic>> get collection => firestore.collection("GoatShed");

  @override
  Future<void> createGoatShed ({ required GoatShedModel goatShed, required File imageFile }) async {
    final newDocRef = collection.doc();
    final newId = newDocRef.id;

    final imageUrl = await uploadShedImage(
        shedId: newId,
        userId: goatShed.userId,
        imageFile: imageFile
    );
    final newShed = goatShed.copyWith(shedId: newId, shedImageUrl: imageUrl);
    return await newDocRef.set(newShed.toJson());
  }

  @override
  Stream<List<GoatShedModel>> getGoatShedList ({ required String userId }) {
    final snapshot = collection
        .where("userId", isEqualTo: userId)
        .snapshots();
    return snapshot.map((snapshot) {
      return snapshot.docs
          .map((doc) => GoatShedModel.fromFirebase(doc))
          .toList();
    });
  }

  @override
  Stream<GoatShedModel> getGoatShedDetail ({ required String shedId }) {
    final snapshot = collection
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
    return await collection.doc(shedId).update(updates);
  }

  @override
  Future<void> changeGoatShedImage ({ required String shedId, required File imageFile }) async {
    final shedRef = await collection.doc(shedId).get();

    if (!shedRef.exists) {
      throw Exception("Kandang dengan ID $shedId tidak ditemukan!");
    }

    final oldData = shedRef.data()!;
    final oldImageUrl = oldData['shedImageUrl'] as String?;
    final userId = oldData['userId'] as String;

    final newImageUrl = await uploadShedImage(shedId: shedId, userId: userId, imageFile: imageFile);

    await updateGoatShed(shedId: shedId, updates: { "shedImageUrl" : newImageUrl });

    if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
      await deleteImage(imageUrl: oldImageUrl);
    }
  }

  Future<String> uploadShedImage ({ required String shedId, required String userId, required File imageFile }) async {
    final fileExtension = p.extension(imageFile.path);
    final mimeType = lookupMimeType(imageFile.path) ?? "image/jpeg";

    if (!mimeType.startsWith("image/")) throw Exception("File bukan gambar yang valid!");

    final fileName = "shed_${shedId}_${DateTime.now().microsecondsSinceEpoch}$fileExtension";
    final storagePath = 'goat_shed_picture/$userId/$fileName';
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

