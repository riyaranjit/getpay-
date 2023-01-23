import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/components/spinner_field_component.dart';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_dimen.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/models/custom_field.dart';
import 'package:dynamic_form/models/selectable.dart';
import 'package:dynamic_form/utils/dynamic_form_style.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:dynamic_form/utils/widget_utils.dart';
import 'package:dynamic_form/widgets/custom_error_label.dart';
import 'package:dynamic_form/widgets/dynamic_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomSpinnerField extends CustomField {
  Function(String) onItemSelected;

  CustomSpinnerField({FieldComponent fieldComponent, this.onItemSelected})
      : super(fieldComponent);

  @override
  State<CustomField> createState() {
    return CustomSpinnerFieldState(controller, onItemSelected: onItemSelected);
  }
}

class CustomSpinnerFieldState extends CustomFieldState with TextController {
  List<Selectable> selectableList = List();
  Selectable selectedSelectable = Selectable();
  SpinnerFieldComponent fieldComponent;
  ValueNotifier<bool> showClearIcon = ValueNotifier(false);
  Function(String) onItemSelected;

  CustomSpinnerFieldState(CustomFieldController controller,
      {this.onItemSelected})
      : super(controller);

  @override
  void initState() {
    super.initState();
    fieldComponent = widget.fieldComponent as SpinnerFieldComponent;
    selectableList = fieldComponent.selectableList;
    setValue(fieldComponent.value);
    updateOnCriteria();
    updateClearIcon();
  }

  String getSelectableLabel(String code) {
    String label = code;
    if (selectableList != null && code != null && !code.isEmpty) {
      for (int i = 0; i < selectableList.length; i++) {
        if (selectableList[i].code.toLowerCase() == code.toLowerCase()) {
          label = selectableList[i].title;
          break;
        }
      }
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    appLog("Building Spinner");
    return Visibility(
      visible: !fieldComponent.isHidden,
      child: DynamicFieldContainer(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AbsorbPointer(
                absorbing: fieldComponent.isReadOnly,
                child: TextFormField(
                  onTap: () {
                    fetchDataAndShowSpinner();
                  },
                  style: fieldComponent.isReadOnly
                      ? DynamicFormStyle.readOnlyfieldTextstyle()
                      : DynamicFormStyle.fieldTextstyle(),
                  focusNode: DisableFocusNode(),
                  enableInteractiveSelection: false,
                  controller: textEditingController,
                  onChanged: (value) {
                    validate();
                  },
                  decoration: getInputDecoration(fieldComponent.hint),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: showClearIcon,
                builder: (_, value, __) {
                  if (value) {
                    return Positioned(
                      right: 24 + AppDimen.medium,
                      child: GestureDetector(
                        onTap: () {
                          clearValue();
                        },
                        child: Container(
                          color: AppColors.white,
                          child: Icon(
                            CupertinoIcons.clear_circled,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    );
                  }
                  return nothing;
                },
              )
            ],
          ),
          CustomErrorLabel(
            message: errorMessage,
          )
        ],
      ),
    );
  }

  void fetchDataAndShowSpinner() async {
    if (selectableList == null || selectableList.isEmpty) {
      //TODO FETCH DATA
    } else {
      promptSelectableDialog();
    }
  }

  @override
  void clearValue() {
    textEditingController.text = "";
    selectedSelectable.code = "";
    selectedSelectable.title = "";
    onChange();
    updateClearIcon();
  }

  @override
  String getFieldValue() {
    return selectedSelectable.code;
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

    var error = validator.validateSpinner(
        data, fieldComponent.hint, fieldComponent.validationRule);
    if (error.isNotEmpty) {
      showError(error);
      return false;
    }

    hideError();
    return true;
  }

  getInputDecoration(String hint) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(8.0),
        fillColor: Colors.white,
        filled: true,
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
        suffixIcon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.orange,
        ),
        hintStyle: normalTextStyle(color: AppColors.grey));
  }

  @override
  State<StatefulWidget> getState() {
    return this;
  }

  @override
  BuildContext getContext() {
    return context;
  }

  void promptSelectableDialog() {
    showSelectableDialog(
      context,
      "",
      fieldComponent.selectableList,
      fieldComponent.hint,
      (value) {
        selectedSelectable.code = value.code;
        selectedSelectable.title = value.title;
        textEditingController.text = value.title;
        validate();
        updateClearIcon();
        onChange();
        if (onItemSelected != null) onItemSelected(value.code);
      },
    );
  }

  @override
  FieldComponent getFieldComponent() {
    return fieldComponent;
  }

  void updateClearIcon() {
    if (textEditingController.text.trim().isNotEmpty &&
        !fieldComponent.isRequired) {
      showClearIcon.value = true;
    } else {
      showClearIcon.value = false;
    }
  }

  @override
  void setValue(String value) {
    textEditingController.text = getSelectableLabel(value);
    selectedSelectable.code = value;
    selectedSelectable.title = getSelectableLabel(value);
  }
}
