import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/goat_shed/data/models/goat_shed_model.dart';

abstract class GoatShedDataSource {
  Future<void> createGoatShed ({required GoatShedModel goatShed });
  Stream<List<GoatShedModel>> getGoatShedList ({ required String ownerId });
  Stream<GoatShedModel> getGoatShedDetail ({required String shedId});
}

class FirestoreGoatShedDataSource implements GoatShedDataSource {
  final FirebaseFirestore firestore;
  FirestoreGoatShedDataSource({ required this.firestore });

  @override
  Future<void> createGoatShed ({ required GoatShedModel goatShed }) async {
    try {
      final newDoc = firestore.collection("goat_shed").doc();
      final newId = newDoc.id;
      final newShed = goatShed.copyWith(id: newId);
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
          .orderBy("createdAt", descending: true)
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

