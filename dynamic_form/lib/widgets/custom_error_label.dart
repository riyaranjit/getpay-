import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomErrorLabel extends StatelessWidget {
  ValueListenable<String> message;

  CustomErrorLabel({this.message});

  @override
  Widget build(BuildContext context) {
    appLog("Building custom error label");
    return ValueListenableBuilder(
      valueListenable: message,
      builder: (context,String errorMessage,child) {
        if(errorMessage.isEmpty) {
          return nothing;
        }
        return Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            errorMessage??"",
            style: xsmallTextStyle(color: AppColors.red),
          ),
        );
      },
    );
  }
}
