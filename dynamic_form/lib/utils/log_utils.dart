import 'package:flutter/foundation.dart';

appLog(String message){
  if(kDebugMode)
    print("##APP LOG## :: $message");
}