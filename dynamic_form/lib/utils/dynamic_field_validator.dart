import 'package:dynamic_form/form/validation_rule.dart';
import 'package:flutter/cupertino.dart';

class DynamicFieldValidator {
  BuildContext buildContext;

  DynamicFieldValidator(this.buildContext);

  String validate(
    String data,
    String fieldName,
    ValidationRule validationRule,
  ) {
    data = data.trim();
    //TODO
    if (data.isEmpty) {
      return "$fieldName can not be empty";
    }

    if (data.length > validationRule.maxLength ||
        data.length < validationRule.minLength) {
      if (validationRule.maxLength == validationRule.minLength)
        return "$fieldName should be of ${validationRule.maxLength} chars";
      return "$fieldName should be of ${validationRule.minLength} to ${validationRule.maxLength} chars";
    }

    if (validationRule.validationRegEx != null) {
      if (!RegExp(validationRule.validationRegEx).hasMatch(data)) {
        return "Invalid $fieldName";
      }
    }

    return "";
  }

  String validateSpinner(
    String data,
    String fieldName,
    ValidationRule validationRule,
  ) {
    data = data.trim();
    if (data.isEmpty) {
      return "Required $fieldName";
    }

    if (data.length > validationRule.maxLength ||
        data.length < validationRule.minLength) {
      return "$fieldName has invalid length";
    }

    if (validationRule.validationRegEx != null) {
      if (!RegExp(validationRule.validationRegEx).hasMatch(data)) {
        return "Invalid $fieldName";
      }
    }

    return "";
  }
}
