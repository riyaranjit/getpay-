import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/models/dynamic_field.dart';
import 'package:dynamic_form/utils/validation_rule_helper.dart';
import 'package:flutter/cupertino.dart';

class AutoCompleteFieldComponent extends FieldComponent {
  String dataSource;
  TextInputType keyboardType;
  double minQueryLength;

  AutoCompleteFieldComponent(DynamicField element) : super(element,
  validationRule: ValidationRuleHelper.getGeneralValidationRule(element)){
    this.dataSource = element.values.dataSource;
    this.keyboardType = element.keyboardType;
    this.minQueryLength = element.minQueryLength;
  }

}