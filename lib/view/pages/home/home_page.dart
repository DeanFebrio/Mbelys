import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/home/widgets/home_app_bar.dart";
import "package:mbelys/view/pages/home/widgets/card_kandang.dart";
import "package:mbelys/view/pages/main_scaffold/main_scaffold.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HomeAppBar(),
            const SizedBox(height: 10,),
            Text(
                "Daftar Kandang",
              style: TextStyle(
                fontSize: 32,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: AppColors.color9
              ),
            ),
            const SizedBox(height: 20,),
            const CardKandang(),
            const SizedBox(height: 20,),
            const CardKandang(),
            const SizedBox(height: 20,),
            const CardKandang(),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
