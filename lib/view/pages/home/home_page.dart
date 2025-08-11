import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/home/widgets/home_app_bar.dart";
import "package:mbelys/view/pages/home/widgets/card_kandang.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(child: const HomeAppBar()),
            const SizedBox(height: 10,),
            const Text(
                "Daftar Kandang",
              style: TextStyle(
                fontSize: 32,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: AppColors.color9
              ),
            ),
            const SizedBox(height: 20,),
            RepaintBoundary(child: const CardKandang()),
            const SizedBox(height: 20,),
            RepaintBoundary(child: const CardKandang()),
            const SizedBox(height: 20,),
            RepaintBoundary(child: const CardKandang()),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
