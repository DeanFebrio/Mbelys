import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/features/launcher/data/datasources/launcher_datasource.dart';
import 'package:mbelys/features/launcher/domain/repositories/launcher_repostitory.dart';

class LauncherRepositoryImpl implements LauncherRepository {
  final LauncherDataSource launcherDataSource;

  const LauncherRepositoryImpl({ required this.launcherDataSource });

  @override
  AsyncVoidResult openWhatsapp({required String name}) async {
    try {
      await launcherDataSource.openWhatsapp(name: name);
      return okVoidAsync();
    } catch (e) {
      rethrow;
    }
  }
}