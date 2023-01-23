
import 'package:dynamic_form/config/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_dimen.dart';

normalTextStyle({Color color = colorPrimary,FontWeight fontWeight}) {
  return TextStyle(color: color, fontSize: FontSize.normal,fontWeight: fontWeight);
}

smallTextStyle({Color color = colorPrimary}) {
  return TextStyle(color: color, fontSize: FontSize.small);
}

xsmallTextStyle({Color color = colorPrimary}) {
  return TextStyle(color: color, fontSize: FontSize.xsmall);
}

largeTextStyle({Color color = colorPrimary,FontWeight fontWeight}) {
  return TextStyle(color: color, fontSize: FontSize.large,fontWeight: fontWeight);
}

xlargeTextStyle({Color color = colorPrimary}) {
  return TextStyle(color: color, fontSize: FontSize.xlarge);
}
