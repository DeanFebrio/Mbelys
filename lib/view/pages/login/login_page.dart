import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/forgot/forgot_page.dart";
import "package:mbelys/view/pages/register/register_page.dart";
import "package:mbelys/view/widgets/auth_background_page.dart";
import "package:mbelys/view/widgets/auth_button.dart";
import "package:mbelys/view/widgets/auth_divider.dart";
import "package:mbelys/view/widgets/auth_text_input.dart";
import "package:mbelys/view/widgets/facebook_button.dart";
import "package:mbelys/view/widgets/google_button.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundPage(
        title: "Masuk",
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
            const SizedBox(height: 8,),
            SizedBox(
              width: 340,
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (e) => const ForgotPage()
                      )
                    );
                  },
                  child: Text(
                      "Lupa password?",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: AppColors.color3
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            AuthButton(
              textButton: "Masuk",
            ),
            const SizedBox(height: 30,),
            AuthDivider(text: "Masuk dengan"),
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
                  "Belum memiliki akun? ",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: AppColors.color3
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (e) => const RegisterPage()
                        )
                    );
                  },
                  child: Text(
                    "Daftar",
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
