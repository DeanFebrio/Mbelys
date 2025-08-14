import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({super.key});

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent)
    );

    return SizedBox(
        width: 340,
        height: 50,
        child: TextFormField(
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 14,
              color: AppColors.color1,
              fontWeight: FontWeight.w600
          ),
          cursorColor: AppColors.color1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20,),
            filled: true,
            fillColor: AppColors.color6,
            hintText: "Ketik disini",
            hintStyle: TextStyle(
                fontFamily: "Mulish",
                fontSize: 14,
                color: AppColors.color14,
                fontWeight: FontWeight.w600
            ),
            border: borderStyle,
            enabledBorder: borderStyle,
            focusedBorder: borderStyle
          ),
        )
    );
  }
}
