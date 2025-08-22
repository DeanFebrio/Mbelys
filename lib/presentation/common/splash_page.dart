import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:shimmer/shimmer.dart";

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/logo_mbelys.png',
              width: 120,
              height: 120,
            ),
            Shimmer.fromColors(
                baseColor: AppColors.color1.withValues(alpha: 0.8),
                highlightColor: AppColors.color12.withValues(alpha: 0.2),
                child: Text(
                  "Mbelys",
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: AppColors.color1
                  ),
                )
            ),
          ],
        )
      ),
    );
  }
}
