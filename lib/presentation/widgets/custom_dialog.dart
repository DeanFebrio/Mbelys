import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

void customDialog(
    BuildContext context,
    String titleText,
    String contentText,
    String buttonText,
    VoidCallback onPressed
    ){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.color6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          title: Text(
            titleText,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                color: AppColors.color1
            ),
          ),
          content: Text(
            contentText,
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Mulish",
                fontWeight: FontWeight.w600,
                color: AppColors.color1
            ),
          ),
          actions: [
            TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.color9
                ),
                child: Text(
                  buttonText,
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
