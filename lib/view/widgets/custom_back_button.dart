import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.pop();
        },
        style: IconButton.styleFrom(
          backgroundColor: AppColors.color7,
        ),
        icon: SvgPicture.asset(
            "assets/icons/back_icon.svg"
        )
    );
  }
}