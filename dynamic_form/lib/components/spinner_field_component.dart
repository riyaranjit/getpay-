import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/form/validation_rule.dart';
import 'package:dynamic_form/models/dynamic_field.dart';
import 'package:dynamic_form/models/selectable.dart';

class SpinnerFieldComponent extends FieldComponent {
  List<Selectable> selectableList;
  String dataSource;
  Map<String,dynamic> payload;

  SpinnerFieldComponent(DynamicField element) : super(element,
  validationRule: ValidationRule.generalTextRule()){
    this.selectableList = element.values.data;
    this.dataSource = element.values.dataSource;
    this.payload = element.values.payload;
  }
}
