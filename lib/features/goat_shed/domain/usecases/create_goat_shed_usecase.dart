// features/goat_shed/domain/usecases/create_goat_shed_usecase.dart
// Use case pembuatan kandang. Jika deviceId kosong, fallback registerDevice().
// Penting: unwrap Either<Failure, String> → String dengan fold.

import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class CreateGoatShedParams {
  final String userId;
  final String? deviceId;
  final String shedName;
  final String shedLocation;
  final int totalGoats;
  final File imageFile;

  const CreateGoatShedParams({
    required this.userId,
    this.deviceId,
    required this.shedName,
    required this.shedLocation,
    required this.totalGoats,
    required this.imageFile,
  });
}

class CreateGoatShedUseCase {
  final GoatShedRepository goatShedRepository;
  final DeviceRepository deviceRepository;
  const CreateGoatShedUseCase({
    required this.goatShedRepository,
    required this.deviceRepository,
  });

  AsyncVoidResult call({ required CreateGoatShedParams params }) async {
    String deviceId = (params.deviceId ?? '').trim();
    if (deviceId.isEmpty) {
      final either = await deviceRepository.registerDevice();
      deviceId = either.fold(
            (f) => throw Exception('Register device gagal: ${f.message}'),
            (v) => v,
      );
    }
    final goatShed = GoatShedEntity(
      shedId: "",
      userId: params.userId,
      deviceId: deviceId,
      shedStatus: "active",
      shedName: params.shedName,
      shedLocation: params.shedLocation,
      shedImageUrl: "",
      totalGoats: params.totalGoats,
      stressStatus: "",
      reproductiveStatus: "",
      recommendation: "",
      explanation: "",
      analyzedAt: null,
    );

    return await goatShedRepository.createGoatShed(
      goatShed: goatShed,
      imageFile: params.imageFile,
    );
  }
}
