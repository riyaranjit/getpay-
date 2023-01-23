import 'package:dynamic_form/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:getpay_merchant_app/common/constants/route_strings.dart';
import 'package:getpay_merchant_app/common/constants/shared_preferences_strings.dart';
import 'package:getpay_merchant_app/common/utils/route/route_handler.dart';
import 'package:getpay_merchant_app/common/utils/shared_pref.dart';

var isLoggedIn;
var initialPath;

Future isUserLogged() async {
  var isLogin = await SharedPref.getBoolValue(
      SharedPreferencesStrings.USER_LOGGED_IN);
  isLoggedIn = isLogin;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.initializeSharedPreferences();
  isUserLogged().whenComplete(() =>
      runMyApp((isLoggedIn == true) ? RouteStrings.dashboardPage : RouteStrings.otpPage));
}

void runMyApp(String route) {
  runApp(MyApp(initialRoute: route));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute}) {
    initialPath= initialRoute;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  onGenerateRoute: RouteHandler.generateRoute,
  theme: ThemeData(
    fontFamily: "Nexa",
  ).copyWith(
    colorScheme: Theme.of(context).colorScheme.copyWith(primary: AppColors.getPayBlue),
    visualDensity: VisualDensity.adaptivePlatformDensity
  ),
   // home: isLoggedIn ?? DashboardPage() : StartUpPage(),
    initialRoute: initialRoute,
    debugShowCheckedModeBanner: false,
  );
  }
  }

