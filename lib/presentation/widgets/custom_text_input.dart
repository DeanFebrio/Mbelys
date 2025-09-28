import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/no_leading_zero_formatter.dart";

class CustomTextInput extends StatefulWidget {
  const CustomTextInput({
    super.key,
    this.hintText = "Ketik disini",
    this.textEditingController,
    this.validator,
    this.isPassword = false,
    this.isNumber = false,
    this.maxLines = 1,
    this.isEnabled = true
  });

  final String? hintText;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isNumber;
  final int maxLines;
  final bool isEnabled;

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool obscureText = true;

  @override void initState() {
    obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent)
    );

    return SizedBox(
        width: 340,
        child: TextFormField(
          controller: widget.textEditingController,
          validator: widget.validator,
          obscureText: widget.isPassword ? obscureText : false,
          keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
          maxLines: widget.maxLines,
          minLines: 1,
          inputFormatters: widget.isNumber
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  NoLeadingZeroFormatter(),
                ]
              : <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9\s.,\-_/()]+")),
                ],
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 14,
              color: AppColors.color1,
              fontWeight: FontWeight.w600
          ),
          cursorColor: AppColors.color1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            filled: true,
            fillColor: AppColors.color6,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontFamily: "Mulish",
                fontSize: 14,
                color: AppColors.color14,
                fontWeight: FontWeight.w600
            ),
            border: borderStyle,
            enabledBorder: borderStyle,
            focusedBorder: borderStyle,
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
        )
    );
  }
}
