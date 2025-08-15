import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomContactButton extends StatelessWidget {
  final String labelText;
  final VoidCallback onTap;

  const CustomContactButton({
    super.key,
    required this.labelText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
