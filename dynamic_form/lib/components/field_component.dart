import 'package:dynamic_form/form/validation_rule.dart';
import 'package:flutter/cupertino.dart';
import 'package:dynamic_form/models/dynamic_field.dart';

abstract class FieldComponent {
  DynamicField element;
  String key;
  String hint;
  bool isRequired;
  bool isReadOnly;
  bool isHidden;
  ValidationRule validationRule;
  String value;
  FocusNode nextFocusNode;
  FocusNode focusNode = FocusNode();
  List<Criteria> visibilityCriterias;
  List<Criteria> requiredCriterias;
  List<Criteria> conditionCriterias;

  FieldComponent(this.element,{this.validationRule}){
    this.key = element.code;
    this.hint = element.title;
    this.isReadOnly = element.constraints.readonly;
    this.isHidden = element.constraints.hidden;
    this.isRequired = element.constraints.required;
    this.value = element.value;
    this.visibilityCriterias = element.constraints.visibleWhen??[];
    this.requiredCriterias = element.constraints.requiredWhen??[];
    this.conditionCriterias = element.constraints.conditionCriterias??[];
  }
}