
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_images.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/utils/device_utils.dart';
import 'package:dynamic_form/utils/image_utils.dart';
import 'package:dynamic_form/utils/widget_utils.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class ImagePreviewDialog extends StatelessWidget {

  String image;
  String title;
  VoidCallback onOK;
  VoidCallback onRetake;

  ImagePreviewDialog({this.image,this.onOK, this.onRetake, this.title = ""});

  @override
  Widget build(BuildContext context) {
    double width =DeviceUtils.getWidth(context, percentage: 90);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(14.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title,style: normalTextStyle(),),
                image==null?Image.asset(AppImages.appLogo):
                Expanded(
                  child: Container(
                    width: width,
                    height: width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: base64ToProvider(image)
                        )
                    ),
                  ),
                ),
                verticalMargin(48.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomButton(
                        onButtonTapped: () {
                          onOK();
                          Navigator.pop(context);
                        },
                        title: "Ok",
                        width: null,
                      ),
                      CustomButton(
                        title: "Retake",
                        onButtonTapped: (){
                          onRetake();
                          Navigator.pop(context);
                        },
                        width: null,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}