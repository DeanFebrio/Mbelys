import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/widgets/custom_background_page.dart";

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundPage(
        title: "Kritik dan Saran",
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 120,),
                Text(
                  "Apa kritik atau saran Anda untuk membantu kami memperbaiki Mbelys?",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.color9,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )
    );
  }
}
