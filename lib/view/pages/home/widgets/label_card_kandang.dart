import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class LabelCardKandang extends StatelessWidget {

  final String textLabel;
  final Color backgroundColor;

  const LabelCardKandang({
    super.key,
    required this.textLabel,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 30,
      width: 75,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text(
          textLabel,
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Mulish",
              fontWeight: FontWeight.w700,
              color: AppColors.color3
          ),
        ),
      ),
    );
  }
}
