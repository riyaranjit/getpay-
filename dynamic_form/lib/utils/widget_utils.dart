import 'package:dynamic_form/config/app_dimen.dart';
import 'package:dynamic_form/datepicker/date_miti_picker.dart';
import 'package:dynamic_form/form/calendar_type.dart';
import 'package:dynamic_form/models/selectable.dart';
import 'package:dynamic_form/widgets/custom_selectable_bottom_sheet.dart';
import 'package:dynamic_form/widgets/image_preview_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'device_utils.dart';
import 'log_utils.dart';

class DisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

Widget verticalMargin([double size = 8]) {
  return SizedBox(
    height: size,
  );
}

Widget horizontalMargin([double size = 8]) {
  return SizedBox(
    width: size,
  );
}

showFullScreenAlertDialog(
    BuildContext context, String title, String image, VoidCallback onOk, VoidCallback onRetake) {
  Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return ImagePreviewDialog(
          image: image,
          title: title,
          onOK: () {
            onOk();
          },
          onRetake: () {
            onRetake();
          },
        );
      },
      fullscreenDialog: false));
}

showSelectableDialog(BuildContext context, String key, List<Selectable> list,
    String title, Function(Selectable) onValueSelected) {
  var selectedValue;
  Future<void> future = showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight,left: AppDimen.medium,right: AppDimen.medium,bottom: AppDimen.medium),
          child: CustomSelectableBottomSheet(
            selectableList: list,
            title: title,
            onValueSelected: (value) {
              selectedValue = value;
//            onValueSelected(value);
            },
          ),
        );
      });
  future.then((value) {
    appLog("selected value: ");
    if (selectedValue == null) {
      selectedValue = Selectable(code: "", title: "");
    }else{
      onValueSelected(selectedValue);
    }

  });
}


showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}

showCustomBottomSheet(BuildContext context,Widget child) {
  showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight,left: AppDimen.medium,right: AppDimen.medium,bottom: AppDimen.medium),
          child: child,
        );
      });
}

showCustomDatePicker(BuildContext context, Function(String bs, String ad) onDateSelected,
    String title,{DateRange dateRange = DateRange.ALL,
      CalendarType calendarType= CalendarType.AD,String initialDate,
      bool allowPresentDate}) {
  showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
            height: DeviceUtils.getHeight(context, percentage: 40),
            child: DateMitiPicker(
              onDateSelected: (bs,ad) {
                Navigator.pop(context);
                onDateSelected(bs,ad);
              },
              title: title,
              dateRange: dateRange,
              calendarType: calendarType,
              initialDate: initialDate,
              allowPresentDate: allowPresentDate,
            ));
      });
}