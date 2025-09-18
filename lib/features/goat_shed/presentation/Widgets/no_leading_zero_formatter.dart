import 'package:flutter/services.dart';

class NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var text = newValue.text;
    if (RegExp(r"^0+$").hasMatch(text)) {
      text = "0";
    } else if (text.length > 1 && text.startsWith('0')) {
      text = text.replaceFirst(RegExp(r'^0+'), '');
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
      composing: TextRange.empty,
    );
  }
}

