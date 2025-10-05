import 'dart:io';

import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/device/domain/repositories/device_repository.dart';
import 'package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart';
import 'package:mbelys/features/goat_shed/domain/repositories/goat_shed_repository.dart';

class CreateGoatShedParams {
  final String userId;
  final String deviceId;
  final String shedName;
  final String shedLocation;
  final int totalGoats;
  final File imageFile;

  const CreateGoatShedParams({
    required this.userId,
    required this.deviceId,
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
    final goatShed = GoatShedEntity(
      shedId: "",
      userId: params.userId,
      deviceId: params.deviceId,
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
