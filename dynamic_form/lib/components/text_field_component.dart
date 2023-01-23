import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/models/dynamic_field.dart';
import 'package:dynamic_form/utils/validation_rule_helper.dart';
import 'package:flutter/cupertino.dart';

class TextFieldComponent extends FieldComponent {
  IconData iconData;
  bool obscureText;
  bool showSuffixIcon;

  TextFieldComponent(DynamicField element,
      {this.iconData, this.obscureText = false, this.showSuffixIcon = false})
      : super(element,
            validationRule:
                ValidationRuleHelper.getGeneralValidationRule(element));
}
