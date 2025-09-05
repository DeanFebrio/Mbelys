import 'package:mbelys/core/utils/result.dart';
import 'package:mbelys/shared/launcher/domain/repositories/launcher_repostitory.dart';

class OpenWhatsappUseCase {
  final LauncherRepository launcherRepository;
  const OpenWhatsappUseCase({ required this.launcherRepository });

  AsyncVoidResult call({ required String name }) async {
    return await launcherRepository.openWhatsapp(name: name);
  }
}