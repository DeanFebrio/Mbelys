import "package:flutter/material.dart";

class CustomLongButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String textButton;
  final Color textColor;
  final Color backgroundColor;

  const CustomLongButton({
    super.key,
    this.onTap,
    required this.textButton,
    required this.textColor,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 340,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        onPressed: onTap,
        child: Text(
          textButton,
          style: TextStyle(
              fontSize: 24,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: textColor
          ),
        )
      ),
    );
  }
}
