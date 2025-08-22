import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.onPressed
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 250,
      child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.color5,
          ),
          child: Text(
            "Keluar",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: AppColors.color13
            ),
          ),
      ),
    );
  }
}
