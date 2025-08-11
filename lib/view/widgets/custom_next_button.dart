import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/detail/detail_page.dart";

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (e) => const DetailPage()
              )
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