import 'package:flutter/material.dart';

getAppBarHeight(context, {double? height}) {
  if (height == null) {
    return  AppBar().preferredSize.height;
  }
  return height;
}
