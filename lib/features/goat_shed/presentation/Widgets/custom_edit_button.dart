import "package:flutter/material.dart";
import "package:icons_plus/icons_plus.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomEditButton extends StatelessWidget {
  const CustomEditButton({
    super.key,
    required this.onPressed
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
            backgroundColor: AppColors.color9,
        ),
        icon: const Icon(MingCute.pencil_fill),
      color: AppColors.color2,
      iconSize: 25,
      padding: const EdgeInsets.all(10),
    );
  }
}
