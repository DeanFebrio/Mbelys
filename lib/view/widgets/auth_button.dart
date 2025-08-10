import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 340,
      child: OutlinedButton(
          onPressed: (){
          },

          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.color8,
            side: BorderSide(
              width: 3,
              color: AppColors.color3
            )
          ),
          child: Text(
              "Daftar",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: AppColors.color3
            ),
          )
      ),
    );
  }
}
