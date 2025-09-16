import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.color10,
    );
  }
}
