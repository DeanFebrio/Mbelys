import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class AuthDivider extends StatelessWidget {
  final String text;
  
  const AuthDivider({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColors.color3,
              thickness: 2,
              radius: BorderRadiusGeometry.all(Radius.circular(20)),
            ),
          ),
          const SizedBox(width: 8,),
          Text(
            text,
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                color: AppColors.color3
            ),
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Divider(
              color: AppColors.color3,
              thickness: 2,
              radius: BorderRadiusGeometry.all(Radius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
}
