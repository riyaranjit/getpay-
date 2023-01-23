import 'package:flutter/services.dart';

class ValidTextInputFormatter extends TextInputFormatter {
  RegExp regExp;

  ValidTextInputFormatter(this.regExp);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    String newText = newValue.text;

    if(newText.isEmpty) {
      return TextEditingValue(
        text: newValue.text,
        selection: newValue.selection,
        composing: TextRange.empty,
      );
    }

    if(regExp.hasMatch(newText)){
      return TextEditingValue(
        text: newValue.text,
        selection: newValue.selection,
        composing: TextRange.empty,
      );

    }
    return oldValue;
  }
}