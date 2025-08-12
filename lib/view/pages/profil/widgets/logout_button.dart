import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/welcome/welcome_page.dart";

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 250,
      child: FilledButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (e) => const WelcomePage()),
                (Route<dynamic> route) => false
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.color5,
          ),
          child: Text(
            "Keluar",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: AppColors.color13
            ),
          ),
      ),
    );
  }
}
