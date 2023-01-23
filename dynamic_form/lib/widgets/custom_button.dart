import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_dimen.dart';
import 'package:dynamic_form/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  Color textColor;
  Color buttonColor;
  Color borderColor;
  double width;
  double borderRadius;
  double borderWidth;
  double height;
  bool clickable;
  VoidCallback onButtonTapped;
  double fontSize;
  Widget prefixIcon;
  bool isLoading;

  CustomButton(
      {this.title,
        this.textColor = Colors.white,
        this.buttonColor = colorPrimary,
        this.borderColor = Colors.white,
        this.borderWidth = 2,
        this.width = double.infinity,
        this.clickable = true,
        this.height = 45.0,
        this.borderRadius = 50.0,
        this.fontSize = 14.0,
        this.onButtonTapped,
        this.prefixIcon,
        this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          color: clickable ? buttonColor : AppColors.black,
          onPressed: () => clickable ? onButtonTapped() : () {},
          child: isLoading
              ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.white,
                strokeWidth: 2.0,
              ))
              : prefixIcon == null
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.small),
            child:Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: fontSize),),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              prefixIcon,
              horizontalMargin(AppDimen.medium),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor, fontSize: fontSize),
              )
            ],
          )),
    );
  }
}