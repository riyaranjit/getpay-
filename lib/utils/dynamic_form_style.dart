import 'dart:ui';
import 'package:dynamic_form/config/app_colors.dart';
import 'package:flutter/material.dart';

import '../config/app_styles.dart';

class DynamicFormStyle {
  static TextStyle readOnlyfieldTextstyle() {
    return largeTextStyle(
        color: AppColors.grey
    );
  }

  static TextStyle fieldTextstyle() {
    return largeTextStyle(color:Colors.black);
  }

  static const dynamicFieldBorderRadius =  BorderRadius.all(Radius.circular(8.0));

}