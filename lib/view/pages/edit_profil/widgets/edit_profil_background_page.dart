import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/widgets/custom_back_button.dart";

class EditProfilBackgroundPage extends StatelessWidget {
  final Widget child;

  const EditProfilBackgroundPage({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.color9,
      body: Stack(
        children: [
          Positioned(
            top: 50,
              left: 20,
              child: CustomBackButton()
          ),
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Profil",
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: AppColors.color3
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
              child: Container(
                width: screenWidth,
                height: 700,
                decoration: BoxDecoration(
                  color: AppColors.color2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )
                ),
              )
          ),
          SafeArea(
              child: child
          )
        ],
      ),
    );
  }
}
