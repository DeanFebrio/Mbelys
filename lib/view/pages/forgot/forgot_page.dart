import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/forgot/widgets/forgot_button.dart";
import "package:mbelys/view/pages/forgot/widgets/forgot_text_input.dart";

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color2,
      appBar: AppBar(
        backgroundColor: AppColors.color2,
        title: Text(
            "Lupa Password",
          style: TextStyle(
            fontSize: 32,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: AppColors.color9
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Masukkan Email",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                color: AppColors.color9
              ),
            ),
            const SizedBox(height: 10,),
            ForgotTextInput(hintText: "Ketikkan email"),
            const SizedBox(height: 20,),
            ForgotButton()
          ],
        ),
      ),
    );
  }
}
