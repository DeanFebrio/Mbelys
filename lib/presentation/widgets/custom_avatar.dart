import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomAvatar extends StatelessWidget {
  final double radius;

  const CustomAvatar({
    super.key,
    this.radius = 37
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.color10,
      child: CircleAvatar(
        backgroundColor: AppColors.color2,
        radius: radius - 4,
        child: CircleAvatar(
          backgroundColor: AppColors.color2,
          radius: radius - 7,
          foregroundImage: AssetImage("assets/images/mbeky_avatar.png"),
        ),
      ),
    );
  }
}
