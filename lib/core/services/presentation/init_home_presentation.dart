import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_list_usecase.dart';
import 'package:mbelys/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

Future<void> initHomePresentation () async {
  sl.registerLazySingleton<HomeViewModel>(() => HomeViewModel(
      profileViewModel: sl<ProfileViewModel>(),
      getGoatShedListUseCase: sl<GetGoatShedListUseCase>()
  ));
}