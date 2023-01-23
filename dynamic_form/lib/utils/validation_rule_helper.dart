import 'package:dynamic_form/form/validation_rule.dart';
import 'package:dynamic_form/models/dynamic_field.dart';

class ValidationRuleHelper {

  static ValidationRule getGeneralValidationRule(DynamicField dynamicField) {
    ValidationRule validationRule = ValidationRule();
    validationRule = ValidationRule.generalTextRule();
    if(dynamicField.constraints.size != null) {
      validationRule.minLength = dynamicField.constraints.size.minimum.toInt();
      validationRule.maxLength = dynamicField.constraints.size.maximum.toInt();
    }
    if(dynamicField.dataType != null && dynamicField.dataType.format != null) {
      validationRule.validationRegEx = dynamicField.dataType.format.formatter;
    }
    return validationRule;
  }

}