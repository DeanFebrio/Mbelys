import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class AuthBackgroundPage extends StatelessWidget {
  final String title;
  final Widget child;

  const AuthBackgroundPage({
    super.key,
    required this.title,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.color2,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage(
                      "assets/images/auth_background.png",
                  ),
                fit: BoxFit.cover
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.1,
              left:  0,
              right: 0,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 64,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: AppColors.color1
                  ),
                ),
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.75,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.color9,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50)
                ),
              ),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
