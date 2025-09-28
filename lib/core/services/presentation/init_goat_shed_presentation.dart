import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_image_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_location_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_shed_name_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/change_total_goats_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/create_goat_shed_usecase.dart';
import 'package:mbelys/features/goat_shed/domain/usecases/get_goat_shed_detail_usecase.dart';
import 'package:mbelys/features/goat_shed/presentation/viewmodel/add_viewmodel.dart';
import 'package:mbelys/features/goat_shed/presentation/viewmodel/detail_viewmodel.dart';
import 'package:mbelys/features/goat_shed/presentation/viewmodel/edit_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodels/profile_viewmodel.dart';

Future<void> initGoatShedPresentation () async {
  sl.registerFactory<AddViewModel>(() => AddViewModel(
      createGoatShed: sl<CreateGoatShedUseCase>(),
      profileViewModel: sl<ProfileViewModel>(),
  ));

  sl.registerFactoryParam<DetailViewModel, String, void>(
          (shedId, _) => DetailViewModel(
              getGoatShedDetail: sl<GetGoatShedDetailUseCase>(),
              shedId: shedId
          )
  );

  sl.registerFactoryParam<EditViewModel, String, void>((shedId, _) {
    return EditViewModel(
      changeShedNameUseCase: sl<ChangeShedNameUseCase>(),
      changeShedLocationUseCase: sl<ChangeShedLocationUseCase>(),
      changeShedImageUseCase: sl<ChangeShedImageUseCase>(),
      changeTotalGoatsUseCase: sl<ChangeTotalGoatsUseCase>(),
      detailViewModel: sl<DetailViewModel>(param1: shedId),
    );
  });
}