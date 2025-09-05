import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherDataSource {
  final FirebaseRemoteConfig remoteConfig;
  const LauncherDataSource({ required this.remoteConfig });

  Future<void> openWhatsapp ({ required String name }) async {
    final phoneNumber = remoteConfig.getString("wa_phoneNumber");
    final message = "Halo admin Mbelys, saya $name ingin bertanya terkait aplikasi Mbelys 😁";

    final url = Uri.parse("https://wa.me/$phoneNumber?text=$message");
    final result = await canLaunchUrl(url);
    if (result) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Tidak dapat membuka aplikasi Whatsapp!");
    }
  }
}