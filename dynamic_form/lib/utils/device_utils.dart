import 'package:flutter/material.dart';

class DeviceUtils {
  static getHeight(BuildContext context, {double percentage}) {
    if (percentage == null) return MediaQuery.of(context).size.height;
    return (MediaQuery.of(context).size.height * percentage) / 100;
  }

  static bool isSmallerDevice(BuildContext context){
    return getHeight(context) < 600;
  }

  static bool isKeyboardShowing(BuildContext context){
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }

  static getWidth(BuildContext context, {int percentage}) {
    if (percentage == null) return MediaQuery.of(context).size.width;
    return (MediaQuery.of(context).size.width * percentage) / 100;
  }
}