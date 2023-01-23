import 'package:flutter/material.dart';

class Validator {
  //TODO localize or?
  BuildContext context;

  Validator(this.context);

  String validateEmail(String value) {
    if(checkEmpty(value) != null) {
      return checkEmpty(value);
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    // if(!regex.hasMatch(value)) {
    //   return getLocalizedString(context, ResString.field_error_email);
    // }

    return null;

  }

  String validatePassword(String password) {
    return checkEmpty(password);
  }

  String checkEmpty(String data) {
    // if(data.trim().isEmpty) {
    //   return getLocalizedString(context, ResString.field_error_required);
    // }
    return null;
  }

  String validateNameField(String name) {
    if(checkEmpty(name) != null)
      return checkEmpty(name);

    // if (name.length > 26) {
    //   return getLocalizedString(context, ResString.field_error_max_char_message,args: [26]);
    // }
  }

  String validateOptionalNameField(String name) {

    // if (name.length > 26) {
    //   return getLocalizedString(context, ResString.field_error_max_char_message,args: [26]);
    // }
  }

  String validateOptionalMobileNumber(String data) {
    // if(data.trim().isEmpty) {
    //   return null;
    // }
    // if (data.trim().length < 8) {
    //   return getLocalizedString(context, ResString.field_error_min_char_message,args: [8]);
    // }
    // if (data.trim().length > 15) {
    //   return getLocalizedString(context, ResString.field_error_max_char_message,args: [15]);
    // }
    return null;
  }


  String validatePin(String data) {
    // if (data.isEmpty) {
    //   return getLocalizedString(context, ResString.field_error_required_pin);
    // }
    return null;
  }


}