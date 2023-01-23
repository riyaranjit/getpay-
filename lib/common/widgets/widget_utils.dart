import 'package:dynamic_form/config/app_colors.dart';
import 'package:flutter/material.dart';

Widget verticalMargin(double height) {
  return SizedBox(
    height: height,
  );
}

Widget horizontalMargin(double width) {
  return SizedBox(
    width: width,
  );
}

customAppBar(String title, BuildContext context,
    {bool backPressRemove = false}) {
  return SafeArea(
    child: Container(
      // decoration: BoxDecoration(boxShadow: <BoxShadow>[
      //   BoxShadow(
      //     color: Colors.grey,
      //     offset: Offset(0.0, 0.5),
      //   )
      // ], color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            backPressRemove
                ? SizedBox()
                : GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back)),
            (backPressRemove) ? horizontalMargin(16.0) : SizedBox(),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}