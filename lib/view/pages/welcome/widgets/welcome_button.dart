import "package:flutter/material.dart";

class WelcomeButton extends StatelessWidget {
  final String textButton;
  final Color backgroundColor;
  final Color textColor;
  final Widget onTap;

  const WelcomeButton({
    super.key,
    required this.textButton,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap
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
          onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (e) => onTap
              )
          );
          },
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
