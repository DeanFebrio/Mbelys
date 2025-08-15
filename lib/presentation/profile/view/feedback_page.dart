import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/profile/widgets/feedback_send_button.dart";
import "package:mbelys/presentation/profile/widgets/feedback_text_input.dart";
import "package:mbelys/presentation/widgets/custom_background_page.dart";

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundPage(
        title: "Kritik dan Saran",
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 150,),
                Text(
                  "Apa kritik atau saran Anda untuk membantu kami memperbaiki Mbelys?",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.color1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                const FeedbackTextInput(),
                const SizedBox(height: 20,),
                const FeedbackSendButton()
              ],
            ),
          ),
        )
    );
  }
}
