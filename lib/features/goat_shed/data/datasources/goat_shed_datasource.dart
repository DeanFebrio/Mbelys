import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/features/goat_shed/data/models/goat_shed_model.dart';

abstract class GoatShedDataSource {
  Future<void> createGoatShed ({required GoatShedModel goatShed });
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
}

