import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mbelys/core/error/failure.dart';
import 'package:mbelys/core/error/firestore_error_mapper.dart';
import 'package:mbelys/core/error/storage_error_mapper.dart';
import 'package:mbelys/core/utils/logger.dart';
import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/goat_shed/data/datasources/goat_shed_datasource.dart';
import 'package:mbelys/features/goat_shed/data/models/goat_shed_model.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class GoatShedRepositoryImpl implements GoatShedRepository {
  final GoatShedDataSource goatShedDataSource;
  const GoatShedRepositoryImpl({required this.goatShedDataSource});

  @override
  AsyncVoidResult createGoatShed ({required GoatShedEntity goatShed, required File imageFile }) async {
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
      await goatShedDataSource.createGoatShed(goatShed: goatShedModel, imageFile: imageFile);
      logInfoLazy(() => "✅ Successfully created goat shed: ${goatShed.shedName}");
      return okUnit();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in createGoatShed", error: e, stackTrace: stackTrace);
      if (e.plugin == "firebase_storage") return err(mapFirebaseStorageError(e));
      return err(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in createGoatShed", error: e, stackTrace: stackTrace);
      return err(DatabaseFailure("Terjadi kesalahan saat membuat kandang, coba lagi nanti"));
    }
  }

  @override
  Stream<List<GoatShedEntity>> getGoatShedList ({required String ownerId}) {
    try {
      return goatShedDataSource
          .getGoatShedList(ownerId: ownerId)
          .map((list) => list.map((m) => m.toEntity())
          .toList());
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in getGoatShedList", error: e, stackTrace: stackTrace);
      return Stream.error(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in getGoatShedList", error: e, stackTrace: stackTrace);
      throw DatabaseFailure("Gagal mendapatkan daftar kandang kambing, coba lagi nanti");
    }
  }

  @override
  Stream<GoatShedEntity> getGoatShedDetail ({required String shedId}) {
    try {
      return goatShedDataSource
          .getGoatShedDetail(shedId: shedId)
          .map((m) => m.toEntity());
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in getGoatShedDetail", error: e, stackTrace: stackTrace);
      return Stream.error(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in getGoatShedDetail", error: e, stackTrace: stackTrace);
      throw DatabaseFailure("Gagal mendapatkan detail kandang kambing, coba lagi nanti");
    }
  }

  @override
  AsyncVoidResult changeGoatShedName ({ required String shedId, required String newName }) async {
    try {
      await goatShedDataSource.updateGoatShed(shedId: shedId, updates: {"shedName": newName});
      logInfoLazy(() => "✅ Successfully changed goat shed name: $newName");
      return okUnit();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in changeGoatShedName", error: e, stackTrace: stackTrace);
      return err(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in changeGoatShedName", error: e, stackTrace: stackTrace);
      return err(DatabaseFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncVoidResult changeGoatShedLocation ({ required String shedId, required String newLocation }) async {
    try {
      await goatShedDataSource.updateGoatShed(shedId: shedId, updates: {"shedLocation": newLocation});
      logInfoLazy(() => "✅ Successfully changed goat shed location: $newLocation");
      return okUnit();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in changeGoatShedLocation", error: e, stackTrace: stackTrace);
      return err(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in changeGoatShedLocation", error: e, stackTrace: stackTrace);
      return err(DatabaseFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncVoidResult changeTotalGoats ({ required String shedId, required int newTotal }) async {
    try {
      await goatShedDataSource.updateGoatShed(shedId: shedId, updates: {"totalGoats": newTotal});
      logInfoLazy(() => "✅ Successfully changed total goats: $newTotal");
      return okUnit();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in changeTotalGoats", error: e, stackTrace: stackTrace);
      return err(mapFirestoreError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in changeTotalGoats", error: e, stackTrace: stackTrace);
      return err(DatabaseFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }

  @override
  AsyncVoidResult changeGoatShedImage ({ required String shedId, required File newImageFile }) async {
    try {
      await goatShedDataSource.changeGoatShedImage(shedId: shedId, newImageFile: newImageFile);
      logInfoLazy(() => "✅ Successfully changed goat shed image: ${newImageFile.path}");
      return okUnit();
    } on FirebaseException catch (e, stackTrace) {
      logger.w("❌ Firebase Error in changeGoatShedImage", error: e, stackTrace: stackTrace);
      if (e.plugin == "firebase_storage") return err(mapFirebaseStorageError(e));
      return err(mapFirebaseStorageError(e));
    } catch (e, stackTrace) {
      logger.e("💥 Error in changeGoatShedImage", error: e, stackTrace: stackTrace);
      return err(StorageFailure("Terjadi kesalahan yang tidak diketahui, coba lagi nanti"));
    }
  }
}