import 'package:dynamic_form/config/app_dimen.dart';
import 'package:dynamic_form/utils/device_utils.dart';
import 'package:flutter/material.dart';

class DynamicFieldContainer extends StatelessWidget {
  List<Widget> children;

  DynamicFieldContainer({this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getWidth(context),
      padding: EdgeInsets.only(top: AppDimen.xsmall, left: AppDimen.medium, right: AppDimen.medium, bottom: AppDimen.medium),
      margin: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}