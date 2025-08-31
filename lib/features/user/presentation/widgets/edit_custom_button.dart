import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class EditCustomButton extends StatelessWidget {
  const EditCustomButton({
    super.key,
    this.textButton,
    this.onPressed
  });

  final String? textButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 340,
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor: AppColors.color2,
            side: BorderSide(
              color: AppColors.color14,
              width: 2
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textButton ?? "Button",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: AppColors.color9
                ),
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          )
      ),
    );
  }
}
