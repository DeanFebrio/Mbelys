import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";

class PasswordButton extends StatelessWidget {
  const PasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 340,
      child: OutlinedButton(
          onPressed: (){
            context.push(RouterPath.password);
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor: AppColors.color2,
            side: BorderSide(
              color: AppColors.color14,
              width: 2
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: AppColors.color9
                ),
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          )
      ),
    );
  }
}
