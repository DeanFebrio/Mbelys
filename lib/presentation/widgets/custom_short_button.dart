import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomShortButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  final bool isLoading;
  final bool isOnTop;

  const CustomShortButton({
    super.key,
    this.onTap,
    required this.buttonText,
    this.isLoading = false,
    this.isOnTop = false
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: isLoading ? null : onTap,
        style: FilledButton.styleFrom(
          minimumSize: const Size(120, 20),
          backgroundColor: isOnTop ? AppColors.color9.withValues(alpha: 0.5) : AppColors.color9,
          disabledBackgroundColor: isOnTop ? AppColors.color9.withValues(alpha: 0.5) : AppColors.color9,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          )
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child,),
          child: isLoading ?
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: isOnTop ? AppColors.color2.withValues(alpha: 0.8) : AppColors.color2,
              backgroundColor: Colors.transparent,
            ),
          )
              :
          Text(
            buttonText,
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                color: AppColors.color2
            ),
          )
        ),
    );
  }
}
