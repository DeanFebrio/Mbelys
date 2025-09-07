import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/create_goat_shed_usecase.dart';
import 'package:mbelys/features/goat_shed/presentation/viewmodel/add_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

Future<void> initGoatShedPresentation () async {
  sl.registerLazySingleton<AddViewModel>(() => AddViewModel(
      createGoatShed: sl<CreateGoatShedUseCase>(),
      profileViewModel: sl<ProfileViewModel>()
  ));
}