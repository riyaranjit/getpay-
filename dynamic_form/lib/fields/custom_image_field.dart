import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/components/image_field_component.dart';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_dimen.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/models/custom_field.dart';
import 'package:dynamic_form/utils/image_utils.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:dynamic_form/utils/widget_utils.dart';
import 'package:dynamic_form/widgets/custom_error_label.dart';
import 'package:dynamic_form/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class CustomImageField extends CustomField {
  CustomImageField({
    FieldComponent fieldComponent,
  }) : super(fieldComponent);

  @override
  State<CustomField> createState() {
    return CustomImageFieldState(controller);
  }
}

class CustomImageFieldState extends CustomFieldState {
  Color borderColor = AppColors.grey;
  ImageFieldComponent fieldComponent;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  String imageContent = "";
  bool hasImage = false;
  int maxFileSize = 40;
  bool hasCaptured = false;

  CustomImageFieldState(CustomFieldController controller) : super(controller);

  @override
  void initState() {
    super.initState();
    fieldComponent = widget.fieldComponent as ImageFieldComponent;
    maxFileSize = fieldComponent.validationRule.maxLength;
    if (fieldComponent.value.isNotEmpty) {
      hasImage = true;
      getImage(fieldComponent.value);
    }
    updateOnCriteria();
  }

  @override
  Widget build(BuildContext context) {
    appLog("Building ImageField");
    return GestureDetector(
      onTap: () {
        if (imageContent.isNotEmpty) {
          showImagePreview(imageContent);
        } else {
          if (fieldComponent.isReadOnly && !isLoading.value) {
            showImagePreview(imageContent);
          } else {
            capture();
          }
        }
      },
      child: Visibility(
        visible: !fieldComponent.isHidden,
        child: AbsorbPointer(
          absorbing: fieldComponent.isReadOnly ?? false,
          child: Padding(
            padding: EdgeInsets.all(AppDimen.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fieldComponent.hint,
                  style: smallTextStyle(color: AppColors.grey),
                ),
                verticalMargin(AppDimen.xsmall),
                ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, bool value, child) {
                    if (value) {
                      return CustomShimmer(
                        enable: true,
                        child: Container(
                          width: 120,
                          height: 120,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 16.0),
                          decoration: BoxDecoration(color: AppColors.grey),
                        ),
                      );
                    }
                    if (hasImage) {
                      if (errorMessage.value.isNotEmpty) {
                        return Container(
                          width: 120,
                          height: 120,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 16.0),
                          decoration: BoxDecoration(color: AppColors.grey),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getImage(fieldComponent.value);
                                },
                                child: Text(
                                  "Retry",
                                  style:
                                      normalTextStyle(color: AppColors.white),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  capture();
                                },
                                child: Text(
                                  "Retake",
                                  style:
                                      normalTextStyle(color: AppColors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                        width: 120,
                        height: 120,
                        child: Image.memory(
                          base64ToBytes(imageContent),
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Container(
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 16.0),
                        decoration: BoxDecoration(color: AppColors.grey),
                        child: Icon(
                          Icons.image,
                          color: AppColors.black.withOpacity(0.2),
                        ),
                      );
                    }
                  },
                ),
                CustomErrorLabel(
                  message: errorMessage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void capture() async {
    //TODO as per needed
  }

  @override
  void clearValue() {}

  @override
  String getFieldValue() {
    if (hasCaptured) {
      return imageContent;
    } else {
      return fieldComponent.value;
    }
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
    if (fieldComponent.isHidden || !fieldComponent.isRequired) {
      hideError();
      return true;
    }
    if (imageContent.isEmpty) {
      errorMessage.value = "No image"; //TODO modify
      return false;
    }

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
  void setValue(dynamic value) {
    getImage(value);
  }

  void getImage(String image) async {}

  void showImagePreview(String image) {
    showFullScreenAlertDialog(context, fieldComponent.hint, image, () {
      setState(() {
        imageContent = image;
        hasCaptured = true;
        hasImage = true;
        hideError();
      });
    }, () {
      setState(() {
        imageContent = "";
        hasImage = false;
      });
      capture();
    });
  }
}
