import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/components/number_field_component.dart';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/models/custom_field.dart';
import 'package:dynamic_form/utils/dynamic_form_style.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:dynamic_form/widgets/custom_error_label.dart';
import 'package:dynamic_form/widgets/dynamic_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomNumberField extends CustomField {

  CustomNumberField({
    FieldComponent fieldComponent,
  }) : super(fieldComponent);

  @override
  State<CustomField> createState() {
    return CustomNumberFieldState(controller);
  }
}

class CustomNumberFieldState extends CustomFieldState with TextController {
  
  NumberFieldComponent fieldComponent;

  CustomNumberFieldState(CustomFieldController controller) : super(controller);

  @override
  void initState() {
    super.initState();
    fieldComponent = widget.fieldComponent as NumberFieldComponent;
    setValue(fieldComponent.value);
    updateOnCriteria();
  }

  @override
  Widget build(BuildContext context) {
    appLog("Building TextField");
    return Visibility(
        visible: !fieldComponent.isHidden,
        child: DynamicFieldContainer(
          children: [
            AbsorbPointer(
              absorbing: fieldComponent.isReadOnly,
              child: TextFormField(
                controller: textEditingController,
                maxLength: fieldComponent.validationRule.maxLength,
                onChanged: (value) {
                  validate();
                  onChange();
                },
                keyboardType: TextInputType.number,
                focusNode: fieldComponent.focusNode,
                textInputAction: fieldComponent.nextFocusNode == null
                    ? TextInputAction.done
                    : TextInputAction.next,
                onFieldSubmitted: (term) {
                  fieldComponent.focusNode.unfocus();
                  FocusScope.of(context)
                      .requestFocus(fieldComponent.nextFocusNode);
                },
                style: fieldComponent.isReadOnly?DynamicFormStyle.readOnlyfieldTextstyle():
                DynamicFormStyle.fieldTextstyle(),
                decoration: getInputDecoration(fieldComponent.hint),
              ),
            ),
            CustomErrorLabel(
              message: errorMessage,
            )
          ],
        )
    );
  }

  getInputDecoration(String hint) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(8.0),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.0),
            borderRadius: DynamicFormStyle.dynamicFieldBorderRadius
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.0),
            borderRadius: DynamicFormStyle.dynamicFieldBorderRadius
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.0),
            borderRadius: DynamicFormStyle.dynamicFieldBorderRadius
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.0),
            borderRadius: DynamicFormStyle.dynamicFieldBorderRadius
        ),
        border: InputBorder.none,
        labelText: hint,
        labelStyle: normalTextStyle(color: AppColors.grey),
        counterText: "",
        hintStyle: normalTextStyle(color: AppColors.grey));
  }

  @override
  void clearValue() {
    textEditingController.text = "";
    onChange();
  }

  @override
  String getFieldValue() {
    return textEditingController.text.trim();
  }

  @override
  void renderField() {
    // TODO: implement renderField
  }

  @override
  void updateValue() {
    // TODO: implement updateValue
  }

  @override
  bool validate() {
    var data = textEditingController.text;
    if (fieldComponent.isHidden) {
      hideError();
      return true;
    }

    if(!fieldComponent.isRequired && data.trim().isEmpty) {
      hideError();
      return true;
    }

    var error = validator.validate(data,fieldComponent.hint,fieldComponent.validationRule);
    if(error.isNotEmpty) {
      showError(error);
      return false;
    }

    hideError();
    return true;

  }

  @override
  State<StatefulWidget> getState() {
    return this;
  }

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  FieldComponent getFieldComponent() {
    return fieldComponent;
  }

  @override
  void setValue(String value) {
    textEditingController.text = fieldComponent.value;
  }
}
