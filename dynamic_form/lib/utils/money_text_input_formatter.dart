import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text;

    if('.'.allMatches(newText).length > 1){

      return TextEditingValue(
        text: oldValue.text,
        selection: oldValue.selection,
        composing: TextRange.empty,
      );

    }

    return newValue;
  }
}