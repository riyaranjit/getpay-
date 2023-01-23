import 'package:dynamic_form/components/date_field_component.dart';
import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/components/image_field_component.dart';
import 'package:dynamic_form/components/number_field_component.dart';
import 'package:dynamic_form/components/spinner_field_component.dart';
import 'package:dynamic_form/components/text_field_component.dart';
import 'package:dynamic_form/components/textview_field_component.dart';
import 'package:dynamic_form/fields/custom_date_field.dart';
import 'package:dynamic_form/fields/custom_image_field.dart';
import 'package:dynamic_form/fields/custom_number_field.dart';
import 'package:dynamic_form/fields/custom_spinner_field.dart';
import 'package:dynamic_form/fields/custom_text_field.dart';
import 'package:dynamic_form/fields/custom_textview_field.dart';
import 'package:dynamic_form/models/custom_field.dart';
import 'package:flutter/cupertino.dart';

abstract class FormBuilder {
  Map<String, CustomField> formMap = Map();
  Map<String, FieldComponent> formCom = Map();

  Widget buildField(FieldComponent fieldComponent) {
    if (formMap.containsKey(fieldComponent.key)) {
      return formMap[fieldComponent.key];
    } else {
      CustomField customField;
      if (fieldComponent is TextFieldComponent) {
        customField = CustomTextField(
          fieldComponent: fieldComponent,
        );
      } else if (fieldComponent is SpinnerFieldComponent) {
        customField = CustomSpinnerField(
          fieldComponent: fieldComponent,
        );
      } else if (fieldComponent is NumberFieldComponent) {
        customField = CustomNumberField(
          fieldComponent: fieldComponent,
        );
      } else if (fieldComponent is DateFieldComponent) {
        customField = CustomDateField(
          fieldComponent: fieldComponent,
        );
      } else if (fieldComponent is TextviewFieldComponent) {
        customField = CustomTextviewField(
          fieldComponent: fieldComponent,
        );
      } else if (fieldComponent is ImageFieldComponent) {
        customField = CustomImageField(
          fieldComponent: fieldComponent,
        );
      }
      customField.getValueOf = (value) {
        return formMap[value].controller.getFieldValue();
      };
      customField.getLabelOf = (value) {
        return formMap[value].fieldComponent.element.title;
      };
      customField.onChange = (formKey, formFieldValue) {
        formMap.forEach((key, value) {
          value.controller.notify(formKey, formFieldValue);
        });
      };
      formMap[fieldComponent.key] = customField;
      formCom[fieldComponent.key] = fieldComponent;
      return customField;
    }
  }

  bool validateForm() {
    var hasError = false;
    formMap.forEach((key, value) {
      if (!value.controller.validate()) {
        hasError = true;
      }
    });
    return !hasError;
  }

  Map<String, dynamic> getFormData() {
    Map<String, dynamic> data = Map();
    formMap.forEach((key, value) {
      data[key] = formMap[key].controller.getFieldValue();
    });
    return data;
  }
}
