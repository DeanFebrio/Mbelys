import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";

void showForgotSuccessDialog(BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.color6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          title: Text(
              "Email Terkirim",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: AppColors.color1
            ),
          ),
          content: Text(
            "Silahkan cek email anda untuk mengatur ulang sandi",
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Mulish",
                fontWeight: FontWeight.w600,
                color: AppColors.color1
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  context.go(RouterPath.login);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.color9
                ),
                child: Text(
                    "Baik",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Mulish",
                    fontWeight: FontWeight.w600,
                    color: AppColors.color3
                  ),
                )
            )
          ],
        );
      }
  );
}
