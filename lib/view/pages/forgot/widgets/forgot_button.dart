import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/forgot/widgets/forgot_succes_dialog.dart";

class ForgotButton extends StatelessWidget {
  const ForgotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 340,
      child: FilledButton(
          onPressed: (){
            showForgotSucessDialog(context);
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.color9
          ),
          child: Text(
              "Lanjut",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: AppColors.color3
            ),
          ),
      ),
    );
  }
}
