import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color2,
      body: Center(
        child: Text(
          "Halaman tidak ditemukan",
          style: TextStyle(
            fontSize: 32,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: AppColors.color1
          ),
        ),
      ),
    );
  }
}
