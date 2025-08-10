import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/login/login_page.dart";
import "package:mbelys/view/pages/register/register_page.dart";
import "package:mbelys/view/pages/welcome/widgets/welcome_button.dart";

class WelcomePage extends StatelessWidget {

  const WelcomePage({super.key,});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.color2,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/logo_mbelys.png",
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 10,),
              Text(
                "Selamat Datang di Mbelys",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: AppColors.color1
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5,),
              Text(
                  "Aplikasi pemantauan tingkat stres dan aktivitas reproduksi kambing berbasis suara dan IoT",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: AppColors.color1
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30,),
              WelcomeButton(
                  textButton: "Daftar",
                  backgroundColor: AppColors.color9,
                  textColor: AppColors.color3,
                onTap: RegisterPage(),
              ),
              const SizedBox(height: 10,),
              WelcomeButton(
                  textButton: "Masuk",
                  backgroundColor: AppColors.color2,
                  textColor: AppColors.color9,
                onTap: LoginPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
