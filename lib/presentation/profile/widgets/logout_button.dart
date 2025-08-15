import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 250,
      child: FilledButton(
          onPressed: (){
            context.go(RouterPath.login);
          },
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
