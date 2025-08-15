import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/profile/widgets/feedback_success_dialog.dart";

class FeedbackSendButton extends StatelessWidget {
  const FeedbackSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: (){
          showFeedbackSuccessDialog(context);
        },
        style: FilledButton.styleFrom(
            backgroundColor: AppColors.color9,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        child: Text(
          "Kirim",
          style: TextStyle(
              fontSize: 20,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: AppColors.color2
          ),
        )
    );
  }
}
