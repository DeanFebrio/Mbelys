import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/widgets/custom_back_button.dart";

class CustomBackgroundPage extends StatelessWidget {
  final Widget child;
  final String title;

  const CustomBackgroundPage({
    super.key,
    required this.title,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color2,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 50,
                left: 20,
                child: const CustomBackButton()
            ),
            Positioned(
              top: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: AppColors.color9
                    ),
                  ),
                ),
            ),
            SafeArea(
                child: child
            )
          ],
        ),
      ),
    );
  }
}
