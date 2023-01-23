import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/form/calendar_type.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {

  VoidCallback onBSTapped;
  VoidCallback onADTapped;
  CalendarType initialCalendarType;

  CustomSwitch({
    @required this.onBSTapped,
    @required this.onADTapped,
    this.initialCalendarType
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {

  bool isBSSelected = true;
  bool isADSelected = false;

  final parentContainerBorderRadius = 8.0;
  final childBorderRadius = 8.0;

  @override
  void initState() {
    super.initState();
    if(widget.initialCalendarType == CalendarType.BS) {
      isBSSelected = true;
      isADSelected = false;
    }else {
      isBSSelected = false;
      isADSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        width: 80,
        height: 30.0,
        decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.circular(parentContainerBorderRadius),
            border: Border.all(
                width: 2.0,
                color: colorPrimary,

            )
        ),
        child: Row(
          children: <Widget>[
            Expanded(child: GestureDetector(
              onTap: () {
                if(!isBSSelected){
                  onBSSelected();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: isBSSelected?colorPrimary:AppColors.lightBlue,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(childBorderRadius),bottomLeft: Radius.circular(childBorderRadius))
                ),
                child: Center(child: Text("BS",
                  style: TextStyle(
                      color: AppColors.white
                  ),)),
              ),
            ),
            ),
            Expanded(child: GestureDetector(
              onTap: () {
                if(!isADSelected) {
                  onADSelected();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: isADSelected?colorPrimary:AppColors.lightBlue,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(childBorderRadius),bottomRight: Radius.circular(childBorderRadius))
                ),
                child: Center(child: Text("AD",
                  style: TextStyle(
                      color: AppColors.white
                  ),)),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  onBSSelected() {
    setState(() {
      isBSSelected = true;
      isADSelected = false;
      widget.onBSTapped();
    });
  }

  onADSelected() {
    setState(() {

      isBSSelected = false;
      isADSelected = true;
      widget.onADTapped();
    });
  }
}
