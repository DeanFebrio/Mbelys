import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:mbelys/features/auth/domain/usecases/update_name_usecase.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/user/domain/usecases/change_name_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/change_phone_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/open_whatsapp_usecase.dart';
import 'package:mbelys/features/user/domain/usecases/watch_user_data_usecase.dart';
import 'package:mbelys/features/user/presentation/viewmodel/edit_profile_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodel/password_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodel/profile_viewmodel.dart';

Future<void> initUserPresentation () async {
  sl.registerFactory<ProfileViewModel>(() => ProfileViewModel(
      authViewmodel: sl<AuthViewModel>(),
      watchUserDataUseCase: sl<WatchUserDataUseCase>(),
      openWhatsappUseCase: sl<OpenWhatsappUseCase>()
  ));

  sl.registerFactory<EditProfileViewModel>(() => EditProfileViewModel(
      changeNameUseCase: sl<ChangeNameUseCase>(),
      updateNameUseCase: sl<UpdateNameUseCase>(),
      changePhoneUseCase: sl<ChangePhoneUseCase>(),
      profileViewModel: sl<ProfileViewModel>()
  ));

  sl.registerFactory<PasswordViewModel>(() => PasswordViewModel(
      changePasswordUseCase: sl<ChangePasswordUseCase>()
  ));
}