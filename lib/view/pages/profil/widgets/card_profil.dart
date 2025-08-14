import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/view/widgets/custom_avatar.dart";
import "package:mbelys/view/widgets/custom_change_button.dart";

class CardProfil extends StatelessWidget {
  const CardProfil({super.key});

  @override
  Widget build(BuildContext context) {

    final nameStyle = TextStyle(
      fontSize: 20,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
      color: AppColors.color9
    );

    final informationStyle = TextStyle(
      fontSize: 12,
      fontFamily: "Montserrat",
      color: AppColors.color10
    );

    return Card(
      color: AppColors.color13,
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 18,
          children: [
            CustomAvatar(radius: 48,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mbelys",
                    style: nameStyle,
                    softWrap: true,
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    "mbelys123@gmail.com",
                    style: informationStyle,
                    softWrap: true,
                  ),
                  const SizedBox(height: 3,),
                  Text(
                    "08123456789",
                    style: informationStyle,
                  ),
                  const SizedBox(height: 10,),
                  CustomChangeButton(
                    onTap: (){
                      context.push(RouterPath.editProfil);
                    }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
