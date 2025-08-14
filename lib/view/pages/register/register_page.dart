import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/view/widgets/auth_background_page.dart";
import "package:mbelys/view/widgets/auth_button.dart";
import "package:mbelys/view/widgets/auth_divider.dart";
import "package:mbelys/view/widgets/auth_text_input.dart";
import "package:mbelys/view/widgets/facebook_button.dart";
import "package:mbelys/view/widgets/google_button.dart";

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundPage(
        title: "Daftar",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70,),
            AuthTextInput(
              hintText: "Masukkan email",
            ),
            const SizedBox(height: 10,),
            AuthTextInput(
              hintText: "Masukkan password",
            ),
            const SizedBox(height: 10,),
            AuthTextInput(
              hintText: "Masukkan nama",
            ),
            const SizedBox(height: 10,),
            AuthTextInput(
              hintText: "Masukkan nomor telepon",
            ),
            const SizedBox(height: 30,),
            AuthButton(
              textButton: "Daftar",
            ),
            const SizedBox(height: 30,),
            AuthDivider(
              text: "Daftar dengan",
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleButton(),
                const SizedBox(width: 20,),
                FacebookButton()
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah memiliki akun? ",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: AppColors.color3
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    context.go(RouterPath.login);
                  },
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        color: AppColors.color3
                    ),
                  ),
                )
              ],
            )
          ],
        )
    );
  }
}
