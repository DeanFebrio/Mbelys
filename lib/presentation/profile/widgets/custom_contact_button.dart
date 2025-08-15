import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomContactButton extends StatelessWidget {
  final String labelText;

  const CustomContactButton({
    super.key,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 20,
      title: Text(
        labelText,
        style: TextStyle(
            fontSize: 14,
            fontFamily: "Montserrat",
            color: AppColors.color9
        ),
      ),
      trailing: Icon(
          Icons.keyboard_arrow_right,
        color: AppColors.color9,
      ),

    );
  }
}
