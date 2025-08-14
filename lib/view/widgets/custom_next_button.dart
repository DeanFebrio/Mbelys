import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.push(RouterPath.detail);
        },
        style: IconButton.styleFrom(
          backgroundColor: AppColors.color7,
        ),
        icon: SvgPicture.asset(
            "assets/icons/next_icon.svg"
        )
    );
  }
}