import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/launcher/domain/repositories/launcher_repostitory.dart';
import 'package:mbelys/features/launcher/domain/usecases/open_whatsapp_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/change_photo_usecase.dart';
import 'package:mbelys/features/user/domain/repositories/user_repository.dart';
import 'package:mbelys/features/user/domain/usecases/change_name_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/change_phone_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/get_user_data_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/watch_user_data_usecase.dart';

Future<void> initUserDomain () async {
  sl.registerFactory<GetUserDataUseCase>(() => GetUserDataUseCase(
      userRepository: sl<UserRepository>()
  ));

  sl.registerFactory<ChangeNameUseCase>(() => ChangeNameUseCase(
      userRepository: sl<UserRepository>(),
  ));

  sl.registerFactory<ChangePhoneUseCase>(() => ChangePhoneUseCase(
      userRepository: sl<UserRepository>(),
  ));

  sl.registerFactory<WatchUserDataUseCase>(() => WatchUserDataUseCase(
      userRepository: sl<UserRepository>()
  ));

  sl.registerFactory<OpenWhatsappUseCase>(() => OpenWhatsappUseCase(
      launcherRepository: sl<LauncherRepository>()
  ));

  sl.registerFactory<ChangePhotoUseCase>(() => ChangePhotoUseCase(
      repository: sl<UserRepository>()
  ));
}