import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/components/text_field_component.dart';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/models/custom_field.dart';
import 'package:dynamic_form/utils/dynamic_form_style.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:dynamic_form/widgets/custom_error_label.dart';
import 'package:dynamic_form/widgets/dynamic_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomTextField extends CustomField {
  CustomTextField({
    FieldComponent fieldComponent,
  }) : super(fieldComponent);

  @override
  State<CustomField> createState() {
    return CustomTextFieldState(controller);
  }
}

class CustomTextFieldState extends CustomFieldState with TextController {
  TextFieldComponent fieldComponent;

        CustomTextFieldState(CustomFieldController controller) : super(controller);

    @override
    void initState() {
    super.initState();
    fieldComponent = widget.fieldComponent as TextFieldComponent;
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
                obscureText: fieldComponent.obscureText,
                maxLength: fieldComponent.validationRule.maxLength,
                onChanged: (value) {
                  validate();
                  onChange();
                },
                focusNode: fieldComponent.focusNode,
                textInputAction: fieldComponent.nextFocusNode == null
                    ? TextInputAction.done
                    : TextInputAction.next,
                onFieldSubmitted: (term) {
                  fieldComponent.focusNode.unfocus();
                  FocusScope.of(context)
                      .requestFocus(fieldComponent.nextFocusNode);
                },
                style: fieldComponent.isReadOnly
                    ? DynamicFormStyle.readOnlyfieldTextstyle()
                    : DynamicFormStyle.fieldTextstyle(),
                decoration: getInputDecoration(fieldComponent.hint),
                keyboardType: fieldComponent.element.keyboardType,
              ),
            ),
            CustomErrorLabel(
              message: errorMessage,
            )
          ],
        ));
  }

  getInputDecoration(String hint) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(left:16.0, top:4.0, bottom: 4.0, right: 16.0),
        prefixIcon: fieldComponent.iconData == null
            ? null
            : Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Icon(
                  fieldComponent.iconData,
                  size: 18.0,
                ),
              ),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: fieldComponent.showSuffixIcon ? IconButton(
          splashRadius: 10.0,
          icon: fieldComponent.obscureText ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
          onPressed: (){
            setState(() {
              if(fieldComponent.obscureText) {
                fieldComponent.obscureText = false;
              } else{
                fieldComponent.obscureText = true;
              }
            });
          },
        ) : null,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.0),
            borderRadius: DynamicFormStyle.dynamicFieldBorderRadius),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.0),
            borderRadius: DynamicFormStyle.dynamicFieldBorderRadius),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.0),
            borderRadius: DynamicFormStyle.dynamicFieldBorderRadius),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1.0),
            borderRadius: DynamicFormStyle.dynamicFieldBorderRadius),
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

    if (!fieldComponent.isRequired && data.trim().isEmpty) {
      hideError();
      return true;
    }

    var error = validator.validate(
        data, fieldComponent.hint, fieldComponent.validationRule);
    if (error.isNotEmpty) {
      showError(error);
      return false;
    }

    if(fieldComponent.conditionCriterias != null && fieldComponent.conditionCriterias.isNotEmpty) {
      var errorMessage = "";
      fieldComponent.conditionCriterias.forEach((criteria) {
        if (criteria.condition == CRITERIA_IS_EQUAL_TO) {
          if (getValueOf(criteria.fieldName) != data) {
            var label = getLabelOf(criteria.fieldName);
            errorMessage='${fieldComponent.element.title} must match with $label';
          }
        }
      });
      if(errorMessage.isNotEmpty) {
        showError(errorMessage);
        return false;
      }
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
    textEditingController.text = value;
  }
}
