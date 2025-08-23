import "package:flutter/material.dart";
import "package:icons_plus/icons_plus.dart";
import "package:mbelys/core/constant/app_colors.dart";

class FacebookButton extends StatelessWidget {
  const FacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 180,
      child: FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: AppColors.color3
          ),
          onPressed: (){},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Brand(Brands.facebook),
              const SizedBox(width: 10,),
              Text(
                "Facebook",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: AppColors.color1
                ),
              )
            ],
          )
      ),
    );
  }
}
