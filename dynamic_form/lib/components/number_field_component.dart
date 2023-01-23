import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/utils/validation_rule_helper.dart';
import 'package:dynamic_form/models/dynamic_field.dart';

class NumberFieldComponent extends FieldComponent {

  NumberFieldComponent(DynamicField element) : super(element,
      validationRule: ValidationRuleHelper.getGeneralValidationRule(element));
}
