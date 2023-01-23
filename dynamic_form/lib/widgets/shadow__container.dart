import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  Widget child;
  Color color;
  Function() onTap;
  double elevation;

  ShadowContainer({this.child,this.color = AppColors.lightGreen,this.onTap, this.elevation = 4.0});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(0),
        color: color,
        child: InkWell(
// Do onTap() if it isn't null, otherwise do appLog()
            onTap: onTap != null
                ? () => onTap()
                : () {
              appLog('Not set yet');
            },
            child: child));
  }
}