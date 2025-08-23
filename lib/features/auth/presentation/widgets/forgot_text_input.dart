import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class ForgotTextInput extends StatelessWidget {
  final String hintText;

  const ForgotTextInput({
    super.key,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {

    final hintStyle = TextStyle(
        fontSize: 14,
        fontFamily: "Mulish",
        fontWeight: FontWeight.w500,
        color: AppColors.color14
    );

    final inputStyle = TextStyle(
        fontSize: 14,
        fontFamily: "Mulish",
        fontWeight: FontWeight.w600,
        color: AppColors.color14
    );

    final borderStyle = OutlineInputBorder(
        borderSide: BorderSide(
          width: 0,
          color: Colors.transparent
        ),
        borderRadius: BorderRadius.circular(10)
    );

    return SizedBox(
      height: 50,
      width: 340,
      child: TextFormField(
        style: inputStyle,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
            filled: true,
            fillColor: AppColors.color6,
            hintText: hintText,
            hintStyle: hintStyle,
            focusedBorder: borderStyle,
            enabledBorder: borderStyle
        ),
      ),
    );
  }
}
