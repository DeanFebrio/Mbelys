import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

Future<void> initHome () async {
  sl.registerFactory<HomeViewModel>(() => HomeViewModel(
      profileViewModel: sl<ProfileViewModel>()
  ));
}