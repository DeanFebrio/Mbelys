import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class AuthTextInput extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthTextInput({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.validator
  });

  @override
  State<AuthTextInput> createState() => _AuthTextInputState();
}

class _AuthTextInputState extends State<AuthTextInput> {
  bool obscureText = true;

  @override
  void initState() {
    obscureText = widget.isPassword;
    super.initState();
  }

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
      width: 340,
      child: TextFormField(
        style: inputStyle,
        controller: widget.controller,
        obscureText: widget.isPassword ? obscureText : false,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
          filled: true,
          fillColor: AppColors.color3,
          hintText: widget.hintText,
          hintStyle: hintStyle,
          focusedBorder: borderStyle,
          focusedErrorBorder: borderStyle,
          enabledBorder: borderStyle,
          errorBorder: borderStyle,
          errorStyle: TextStyle(
              color: AppColors.color12,
              fontFamily: "Mulish"
          ),
          suffixIcon: widget.isPassword ?
          IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.color1,
              )
          ) : null,
        ),
      ),
    );
  }
}
