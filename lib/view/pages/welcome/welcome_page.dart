import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/view/widgets/custom_button.dart";

class WelcomePage extends StatelessWidget {

  const WelcomePage({super.key,});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                width: 340,
                child: Text(
                  "Selamat Datang di Mbelys",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: AppColors.color1
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 5,),
              SizedBox(
                width: 340,
                child: Text(
                    "Aplikasi pemantauan tingkat stres dan aktivitas reproduksi kambing berbasis suara dan IoT",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    color: AppColors.color1
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50,),
              CustomButton(
                  textButton: "Daftar",
                  backgroundColor: AppColors.color9,
                  textColor: AppColors.color3,
                onTap: () {
                    context.push(RouterPath.register);
                },
              ),
              const SizedBox(height: 10,),
              CustomButton(
                  textButton: "Masuk",
                  backgroundColor: AppColors.color2,
                  textColor: AppColors.color9,
                onTap: () {
                    context.push(RouterPath.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
