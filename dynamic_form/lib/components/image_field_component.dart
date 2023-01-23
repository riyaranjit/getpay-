import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/form/validation_rule.dart';
import 'package:dynamic_form/models/dynamic_field.dart';

class ImageFieldComponent extends FieldComponent {
  ImageFieldComponent(DynamicField element)
      : super(element,
            validationRule: ValidationRule(
                maxLength: element.constraints.size.maximum.toInt())) {
    this.value = element.imageSource ?? element.value;
  }
}
