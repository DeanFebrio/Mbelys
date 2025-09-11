import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/error/firestore_error_mapper.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/data/datasources/goat_shed_datasource.dart';
import 'package:mbelys/features/goat_shed/data/models/goat_shed_model.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class GoatShedRepositoryImpl implements GoatShedRepository {
  final GoatShedDataSource goatShedDataSource;
  const GoatShedRepositoryImpl({required this.goatShedDataSource});

  @override
  AsyncResult<void> createGoatShed ({required GoatShedEntity goatShed, required File imageFile }) async {
    try {
      final goatShedModel = GoatShedModel(
        shedId: "",
        shedName: goatShed.shedName,
        shedLocation: goatShed.shedLocation,
        totalGoats: goatShed.totalGoats,
        ownerId: goatShed.ownerId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      );
      final result = await goatShedDataSource.createGoatShed(goatShed: goatShedModel, imageFile: imageFile);
      return ok(result);
    } on FirebaseException catch (e) {
      return err(mapFirestoreError(e));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<GoatShedEntity>> getGoatShedList ({required String ownerId}) {
    try {
      final result = goatShedDataSource.getGoatShedList(ownerId: ownerId);
      return result;
    } on FirebaseException catch (e) {
      return Stream.error(mapFirestoreError(e));
    }
  }

  @override
  Stream<GoatShedEntity> getGoatShedDetail ({required String shedId}) {
    try {
      final result = goatShedDataSource.getGoatShedDetail(shedId: shedId);
      return result;
    } on FirebaseException catch (e) {
      return Stream.error(mapFirestoreError(e));
    }
  }
}