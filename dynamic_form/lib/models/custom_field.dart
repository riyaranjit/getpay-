import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/models/dynamic_field.dart';
import 'package:dynamic_form/utils/dynamic_field_validator.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';

class CustomFieldController {
  bool Function() validate;
  String Function() getFieldValue;
  Function(String, String) notify;
  void Function() updateOnCriteria;
  void Function(String) setValue;
}

abstract class CustomField extends StatefulWidget {
  FieldComponent fieldComponent;
  CustomFieldController controller = CustomFieldController();

  String Function(String) getValueOf;
  String Function(String) getLabelOf;
  Function(String, String) onChange;
  Function(String, String) setValueCallback;

  CustomField(this.fieldComponent);
}

abstract class CustomFieldState extends State<CustomField> {
  ValueNotifier<String> errorMessage = ValueNotifier("");
  Color borderColor = AppColors.grey;

  DynamicFieldValidator get validator {
    return DynamicFieldValidator(getContext());
  }

  CustomFieldState(CustomFieldController controller) {
    controller.validate = validate;
    controller.getFieldValue = getFieldValue;
    controller.notify = onNotificationReceived;
    controller.updateOnCriteria = updateOnCriteria;
    controller.setValue = setValue;
  }

  FieldComponent getFieldComponent();

  bool validate();

  String getFieldValue();

  void updateValue();

  void clearValue();

  void renderField();

  void setValue(String value);

  BuildContext getContext();

  State getState();

  void hideError() {
    setState(() {
      errorMessage.value = "";
      borderColor = AppColors.grey;
    });
  }

  void showError(String message) {
    setState(() {
      errorMessage.value = message;
      borderColor = AppColors.red;
    });
  }

  String getValueOf(String key) {
    return widget.getValueOf(key);
  }

  String getLabelOf(String key) {
    return widget.getLabelOf(key);
  }

  void onChange() {
    if (widget.onChange != null)
      widget.onChange(getFieldComponent().key, getFieldValue());
  }

  void onNotificationReceived(String key, String value) {
    if (getFieldComponent().visibilityCriterias.isNotEmpty ||
        getFieldComponent().requiredCriterias.isNotEmpty) {
      update();
    }
    if (getFieldComponent().conditionCriterias.isNotEmpty) {
      updateConditionCriteria(getFieldValue());
    }
  }

  void update() {
    getFieldComponent().isRequired =
        getModifiedProperty(getFieldComponent().requiredCriterias);
    getFieldComponent().isHidden =
        !getModifiedProperty(getFieldComponent().visibilityCriterias);
    getState().setState(() {});
    validate();
  }

  void updateOnCriteria() {
    if (getFieldComponent().visibilityCriterias.isNotEmpty ||
        getFieldComponent().requiredCriterias.isNotEmpty) {
      update();
    }
  }

  void updateConditionCriteria(String fieldValue) {
    setModifiedProperty(getFieldComponent().conditionCriterias, fieldValue);
    getState().setState(() {});
  }

  bool getModifiedProperty(List<Criteria> criterias) {
    bool identifierProperty = false;
    criterias.forEach((criteria) {
      if (criteria.condition == CRITERIA_IS) {
        if (getValueOf(criteria.fieldName) == criteria.fromValue) {
          identifierProperty = true;
        }
      }

      if (criteria.condition == CRITERIA_IS_FILLED_OUT) {
        if (getValueOf(criteria.fieldName).trim().isNotEmpty) {
          identifierProperty = true;
        }
      }
    });
    return identifierProperty;
  }

  void setModifiedProperty(
      List<Criteria> conditionCriterias, String fieldValue) {
    conditionCriterias.forEach((element) {
      if (element.condition == CRITERIA_CHANGE_LABEL) {
        appLog("ELEMENT VALUE >>> ${element.fromValue}");
        appLog("ELEMENT SET VALUE >>> ${element.setValue}");
        appLog("ELEMENT FIELD NAME >>> ${element.fieldName}");
        appLog("DEPENDENT FIELD COMPONENT VALUE >>> ${getValueOf(element.fieldName)}");
        if(getValueOf(element.fieldName)!= null) {
          if (getValueOf(element.fieldName).toUpperCase() ==
              element.fromValue.toUpperCase()) {
            getFieldComponent().hint = element.setValue;
            appLog("FIELD COMPONENT HINT >>> ${getFieldComponent().hint}");
          }
        }
      }
    });
  }
}

abstract class TextController {
  TextEditingController textEditingController = TextEditingController();
}
