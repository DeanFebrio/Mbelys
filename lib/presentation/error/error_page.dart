import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

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
              Text(
                "Halaman tidak ditemukan",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: AppColors.color1
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              CustomShortButton(
                  onTap: () => context.go(RouterPath.home),
                  buttonText: "Home"
              )
            ],
          ),
        ),
      ),
    );
  }
}
