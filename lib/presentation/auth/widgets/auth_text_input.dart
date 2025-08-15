import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class AuthTextInput extends StatelessWidget {
  final String hintText;

  const AuthTextInput({
    super.key,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {

    final hintStyle = TextStyle(
        fontSize: 14,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w500,
        color: AppColors.color1
    );

    final inputStyle = TextStyle(
        fontSize: 14,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        color: AppColors.color1
    );

    final borderStyle = OutlineInputBorder(
        borderSide: BorderSide(
            color: AppColors.color1,
            width: 3
        ),
        borderRadius: BorderRadius.circular(50)
    );

    return SizedBox(
      height: 50,
      width: 340,
      child: TextFormField(
        style: inputStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
          filled: true,
          fillColor: AppColors.color3,
          hintText: hintText,
          hintStyle: hintStyle,
          focusedBorder: borderStyle,
          enabledBorder: borderStyle
        ),
      ),
    );
  }
}
