import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class HomeAvatar extends StatelessWidget {
  const HomeAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 37,
      backgroundColor: AppColors.color10,
      child: CircleAvatar(
        backgroundColor: AppColors.color2,
        radius: 34,
        child: CircleAvatar(
          backgroundColor: AppColors.color2,
          radius: 30,
          foregroundImage: AssetImage("assets/images/mbeky_avatar.png"),
        ),
      ),
    );
  }
}
