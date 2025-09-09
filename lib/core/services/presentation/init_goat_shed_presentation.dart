import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/create_goat_shed_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_detail_usecase.dart';
import 'package:mbelys/features/goat_shed/presentation/viewmodel/add_viewmodel.dart';
import 'package:mbelys/features/goat_shed/presentation/viewmodel/detail_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

Future<void> initGoatShedPresentation () async {
  sl.registerFactory<AddViewModel>(() => AddViewModel(
      createGoatShed: sl<CreateGoatShedUseCase>(),
      profileViewModel: sl<ProfileViewModel>()
  ));

  sl.registerFactoryParam<DetailViewModel, String, void>(
          (shedId, _) => DetailViewModel(
              getGoatShedDetail: sl<GetGoatShedDetailUseCase>(),
              shedId: shedId
          )
  );
}