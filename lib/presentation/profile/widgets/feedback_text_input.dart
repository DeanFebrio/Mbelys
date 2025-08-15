import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class FeedbackTextInput extends StatelessWidget {
  const FeedbackTextInput({super.key});

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

    return Container(
      width: 320,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.color6,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: inputStyle,
        decoration: InputDecoration(
          hintText: "Ketik disini",
          hintStyle: hintStyle,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
