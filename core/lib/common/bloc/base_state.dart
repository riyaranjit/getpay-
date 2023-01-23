import 'package:core/common/error/failure.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseState {
  BuildContext getContext();

  void showAlertDialog(Failure failure, {VoidCallback onComplete}) {
    // TODO show alert dialog
  }
}