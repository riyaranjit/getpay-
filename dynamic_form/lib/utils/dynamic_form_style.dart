import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicFormStyle {
  static TextStyle readOnlyfieldTextstyle() {
    return largeTextStyle(
      color: AppColors.grey
    );
  }

  static TextStyle fieldTextstyle() {
    return largeTextStyle(color: null);
  }

  static const dynamicFieldBorderRadius =  BorderRadius.all(Radius.circular(8.0));

}