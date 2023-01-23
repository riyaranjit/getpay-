import 'dart:ffi';

import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/utils/form_builder.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:dynamic_form/utils/widget_utils.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class DynamicForm extends StatefulWidget {
  List<FieldComponent> fieldComponents;
  bool hideSubmitButton;
  String buttonText;
  Function(Map<String, dynamic>) onSubmit;
  bool isUpdate;//todo not used yet
  Color buttonColor;
  double buttonWidth;
  double buttonCornerRadius;

  DynamicForm({
    this.fieldComponents,
    this.hideSubmitButton = false,
    this.buttonText,
    this.onSubmit,
    this.isUpdate = false,
    this.buttonColor = AppColors.orange,
    this.buttonWidth = double.infinity,
    this.buttonCornerRadius = 0.0
  }):super(key: UniqueKey());

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> with FormBuilder {
  List<FieldComponent> dynamicFields;
  Map<String, dynamic> data = Map();

  @override
  void initState() {
    super.initState();
    this.dynamicFields = widget.fieldComponents;
  }

  @override
  Widget build(BuildContext context) {
    appLog("Building form");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getFocusNodeDynamicFields(dynamicFields).map<Widget>((e) => buildField(e)).toList()
                  ..add(verticalMargin(2))
                  ..add(data.keys.length > 0 ? Text("${getData()}") : nothing),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: !widget.hideSubmitButton,
              child: CustomButton(
                onButtonTapped: () async {
                  if (validateForm()) {
                    widget.onSubmit(getFormData());
                  }
                },
                borderRadius: widget.buttonCornerRadius,
                buttonColor: widget.buttonColor,
                title: widget.buttonText == null?"Submit":
                widget.buttonText,
                width: widget.buttonWidth,
              ),
            ),
          ),
          verticalMargin(16.0)
        ],
      ),
    );
  }

  getData() {
    String data = "";
    this.data.forEach((key, value) {
      data += value.toString();
    });
    return data;
  }

  getFocusNodeDynamicFields(List<FieldComponent> dynamicFields) {
    List<FieldComponent> focusFields = [];
    for(int i=0; i < dynamicFields.length; i++){
      FieldComponent fieldComponent = dynamicFields[i];
      if(i<dynamicFields.length-1) {
        fieldComponent.nextFocusNode = dynamicFields[i + 1].focusNode;
      }
      focusFields.add(fieldComponent);
    }
    return focusFields;
  }
}