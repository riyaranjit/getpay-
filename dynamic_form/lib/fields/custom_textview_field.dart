import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/components/textview_field_component.dart';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_dimen.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/models/custom_field.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class CustomTextviewField extends CustomField {

  CustomTextviewField({
    FieldComponent fieldComponent,
  }) : super(fieldComponent);

  @override
  State<CustomField> createState() {
    return CustomTextviewFieldState(controller);
  }
}

class CustomTextviewFieldState extends CustomFieldState {

  TextviewFieldComponent fieldComponent;

  CustomTextviewFieldState(CustomFieldController controller) : super(controller);

  @override
  void initState() {
    super.initState();
    fieldComponent = widget.fieldComponent;
    setValue(fieldComponent.hint);
    updateOnCriteria();
  }

  @override
  Widget build(BuildContext context) {
    appLog("Building TextviewField");
    return Visibility(
      visible: !fieldComponent.isHidden,
      child: Padding(
        padding: const EdgeInsets.all(AppDimen.medium),
        child: Text(
          fieldComponent.hint??"",
          style: normalTextStyle(color: AppColors.black),
        ),
      ),
    );
  }


  @override
  void clearValue() {

  }

  @override
  String getFieldValue() {
    return fieldComponent.hint;
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
    fieldComponent.hint = value;
  }
}
