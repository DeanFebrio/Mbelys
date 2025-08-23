import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/widgets/custom_back_button.dart";

class EditProfileBackgroundPage extends StatelessWidget {
  final Widget child;

  const EditProfileBackgroundPage({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.color9,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.75,
                width: screenWidth,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomBackButton(),
                    Center(
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
                    Expanded(child: child)
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
