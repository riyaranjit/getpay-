import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/form/validation_rule.dart';
import 'package:dynamic_form/models/dynamic_field.dart';
import 'package:dynamic_form/models/selectable.dart';
import 'package:flutter/cupertino.dart';

import 'calendar_type.dart';
import 'form_component_type.dart';

class FieldComponent {
  FormComponentType type;
  String key;
  IconData icon;
  double iconSize;
  ValidationRule validationRule = ValidationRule.generalTextRule();
  FocusNode focusNode = FocusNode();
  String hint;
  List<Selectable> selectable;
  Function(String, String) onSelected;
  bool isMandatory;
  String cascadeWith;
  List<String> childrens;
  double fontSize;
  int maxLines;
  DateRange dateRange;
  String dateFormatter;
  bool allowPresentDate;
  CalendarType calendarType;
  bool autofocus;
  String dataSource;
  bool readOnly;
  String defaultValue;
  String value;
  bool hidden;
  List<String> source;
  double minQueryLength;
  String keyboardType;
  List<Criteria> visibilityCriterias;
  List<Criteria> requiredCriterias;
  Map<String,dynamic> payload;

  FieldComponent(
      {@required this.type,
      @required this.key,
      this.icon,
        this.hint,
      this.validationRule,
      this.iconSize = 24,
      this.selectable,
      this.cascadeWith,
      this.childrens,
      this.isMandatory = true,
      this.onSelected,
      this.fontSize = 18,
      this.maxLines = 1,
      this.autofocus = false,
      this.allowPresentDate = false,
      this.dateRange = DateRange.ALL,
      this.dateFormatter = YYYY_MM_DD,
      this.calendarType = CalendarType.BS,
      this.dataSource,
      this.readOnly = false,
      this.value,
      this.defaultValue,
      this.source,
      this.hidden = false,
      this.minQueryLength,
      this.keyboardType,
      this.visibilityCriterias,
      this.payload,
      this.requiredCriterias})
      : assert(type != null),
        assert(key != null),
        assert(validationRule != null);

  TextInputType getInputType() {
    switch (type) {
      case FormComponentType.PASSWORD:
        return TextInputType.visiblePassword;

      case FormComponentType.EMAIL:
        return TextInputType.emailAddress;

      case FormComponentType.NUMBER:
        return TextInputType.numberWithOptions(decimal: true);

      case FormComponentType.DATE:
        return TextInputType.datetime;

      default:
        return TextInputType.text;
    }
  }
}
