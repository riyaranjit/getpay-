import 'package:dynamic_form/components/date_field_component.dart';
import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_dimen.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/form/calendar_type.dart';
import 'package:dynamic_form/models/custom_field.dart';
import 'package:dynamic_form/utils/dynamic_form_style.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:dynamic_form/utils/string_utils.dart';
import 'package:dynamic_form/utils/widget_utils.dart';
import 'package:dynamic_form/widgets/custom_error_label.dart';
import 'package:dynamic_form/widgets/dynamic_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomDateField extends CustomField {
  CustomDateField({FieldComponent fieldComponent}) : super(fieldComponent);

  @override
  State<CustomField> createState() {
    return CustomDateFieldState(controller);
  }
}

class CustomDateFieldState extends CustomFieldState with TextController {

  DateFieldComponent fieldComponent;
  ValueNotifier<bool> showClearIcon = ValueNotifier(false);
  String dateAD = "";
  String dateBS = "";

  CustomDateFieldState(CustomFieldController controller) : super(controller);

  @override
  void initState() {
    super.initState();
    fieldComponent = widget.fieldComponent as DateFieldComponent;
    setValue(fieldComponent.value);
    updateOnCriteria();
    updateClearIcon();
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
                    if(fieldComponent.calendarType == CalendarType.AD) {
                      DatePicker.showDatePicker(getContext(),
                        showTitleActions: true,
                        minTime: getMinimumDate(fieldComponent),
                        maxTime: getMaximumDate(fieldComponent),
                        onChanged: (date) {

                        },
                        onConfirm: (selectedDate) {
                          appLog('confirm $selectedDate');
                          String date = dateTimeToString(selectedDate);
                          dateAD = date;
                          if(fieldComponent.dateFormatter == MM_DD_YYYY) {
                            date = getMMDDYYYYDate(date);
                          }
                          textEditingController.text = date;
                          onChange();
                        }, currentTime: textEditingController.text.isEmpty?
                        getMaximumDate(fieldComponent):getDateTimeFromString(textEditingController.text), );
                    }else {
                      showCustomDatePicker(getContext(), (bs, ad) {
                        if (ad != "null") {
                          dateBS = bs;
                          dateAD = ad;
                          textEditingController.text =
                              ad +" AD | "+ bs+" BS"
                          ;
                        }
                        onChange();
                      },fieldComponent.hint,
                          dateRange: fieldComponent.dateRange,
                          calendarType: fieldComponent.calendarType,
                          allowPresentDate: fieldComponent.allowPresentDate,
                          initialDate: fieldComponent.calendarType == CalendarType.BS?
                          dateBS:dateAD);
                    }
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
                builder:(_,value,__) {
                  if(value) {
                    return  Positioned(
                      right: 24+AppDimen.medium,
                      child: GestureDetector(
                        onTap: () {
                          clearValue();
                        },
                        child: Icon(CupertinoIcons.clear_circled,
                          color: AppColors.red,),
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

  getMinimumDate(DateFieldComponent component) {
    if(component.dateRange == DateRange.PAST) {
      return DateTime.utc(1920,1,1);
    }else {
      if(component.allowPresentDate) {
        return DateTime.now();
      }else {
        return DateTime.now().toUtc().add(Duration(days: 1));
      }
    }
  }

  getMaximumDate(DateFieldComponent component) {
    if(component.dateRange == DateRange.PAST) {
      if(component.allowPresentDate) {
        return DateTime.now().toUtc();
      }else {
        return DateTime.now().toUtc().subtract(Duration(days: 1));
      }
    }else {
      return DateTime.utc(2040,1,1);
    }
  }


  @override
  void clearValue() {
    textEditingController.text = "";
    dateAD = "";
    onChange();
    updateClearIcon();
  }

  @override
  String getFieldValue() {
    if(fieldComponent.dateFormatter == MM_DD_YYYY) {
      return getMMDDYYYYDate(dateAD);
    }
    return dateAD;
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
        labelText:hint,
        labelStyle: normalTextStyle(color: AppColors.grey),
        counterText: "",
        suffixIcon: Icon(Icons.date_range),
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

  @override
  FieldComponent getFieldComponent() {
    return fieldComponent;
  }

  void updateClearIcon() {
    if(textEditingController.text.trim().isNotEmpty && !fieldComponent.isRequired){
      showClearIcon.value = true;
    }else{
      showClearIcon.value = false;
    }
  }

  @override
  void setValue(String value) {
    textEditingController.text = fieldComponent.value??"";
    dateAD = fieldComponent.value??"";
  }
}
