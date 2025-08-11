import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomLabelStatus extends StatelessWidget {
  final String labelText;

  const CustomLabelStatus({
    super.key,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.color5,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
        child: Text(
          labelText,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: AppColors.color3
          ),
        ),
      ),
    );
  }
}
