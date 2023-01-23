import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static SharedPreferences? _preferences;

  static Future initializeSharedPreferences()async{
    _preferences= await SharedPreferences.getInstance();
  }

  static getBoolValue(String key) async{
    return _preferences!.getBool(key) ?? false;
  }
}