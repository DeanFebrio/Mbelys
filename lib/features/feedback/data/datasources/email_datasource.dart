import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mbelys/features/feedback/data/models/email_model.dart';
import 'package:emailjs/emailjs.dart' as emailJs;

class EmailDataSource {
  Future<void> sendEmail ({required EmailModel emailModel}) async {
    final serviceId = dotenv.env['EMAILJS_SERVICEID'];
    final templateId = dotenv.env['EMAILJS_TEMPLATEID'];
    final publicKey = dotenv.env['EMAILJS_PUBLIC_KEY'];
    final privateKey = dotenv.env['EMAILJS_PRIVATE_KEY'];

    try {
      await emailJs.send(
        serviceId!,
        templateId!,
        emailModel.toJson(),
        emailJs.Options(
          privateKey: privateKey,
          publicKey: publicKey
        )
      );
      return;
    } catch (e) {
      if (e is emailJs.EmailJSResponseStatus) {
        print('ERROR... ${e.status}: ${e.text}');
      }
      print(e.toString());
      throw Exception("Gagal mengirim email: ${e.toString()}");
    }
  }
}