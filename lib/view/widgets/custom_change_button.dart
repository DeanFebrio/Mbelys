import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomChangeButton extends StatelessWidget {
  final Widget onTap;
  
  const CustomChangeButton({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: (){
          Navigator.push(
              context, 
              MaterialPageRoute(builder: (e) => onTap)
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.color5,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        child: Text(
            "Ubah",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: AppColors.color3
          ),
        )
    );
  }
}
