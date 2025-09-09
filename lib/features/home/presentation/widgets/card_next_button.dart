import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";

class CardNextButton extends StatelessWidget {
  final String shedId;
  const CardNextButton({
    super.key,
    required this.shedId
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.pushNamed(
            RouterName.detail,
            pathParameters: {'shedId': shedId}
          );
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