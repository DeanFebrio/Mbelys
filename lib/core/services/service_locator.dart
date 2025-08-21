
import 'package:get_it/get_it.dart';
import 'package:mbelys/core/services/auth_locator.dart';

final sl = GetIt.instance;

Future<void> setupLocator () async {
  initAuth();
}