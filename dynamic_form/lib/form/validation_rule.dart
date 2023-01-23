import 'package:dynamic_form/form/valid_text_input_formatter.dart';
import 'package:dynamic_form/utils/money_text_input_formatter.dart';
import 'package:flutter/services.dart';

class ValidationRule {
  int minLength;
  int maxLength;
  bool isNumber;
  Pattern validationRegEx;
  String shouldMatchedWith;
  List<TextInputFormatter> inputFormatters;
  static const DEFAULT_MIN_LENGTH = 1;

  ValidationRule(
      {this.minLength,
        this.maxLength,
        this.isNumber = false,
        this.validationRegEx,
        this.inputFormatters,
        this.shouldMatchedWith});


  @override
  String toString() {
    return 'ValidationRule{minLength: $minLength, maxLength: $maxLength, isNumber: $isNumber, validationRegEx: $validationRegEx, shouldMatchedWith: $shouldMatchedWith, inputFormatters: $inputFormatters}';
  }

  static generalTextRule({int minLength = 1, int maxLength = 100}) {
    return ValidationRule(
      minLength: minLength,
      maxLength: maxLength,
    );
  }

  static generalMobilePhoneNumberRule() {
    return ValidationRule(
        minLength: 10,
        maxLength: 10,
        isNumber: true,
        inputFormatters: [ValidTextInputFormatter(RegExp(r'^[0-9]+$'))]);
  }

  static amountRule() {
    return ValidationRule(
        minLength: 2,
        maxLength: 10,
        isNumber: true,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9\.]')),
          MoneyTextInputFormatter()
        ]
    );
  }

  static emailRule() {
    return ValidationRule(
        minLength: 10,
        maxLength: 50,
        isNumber: false,
        validationRegEx:
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  }
}
