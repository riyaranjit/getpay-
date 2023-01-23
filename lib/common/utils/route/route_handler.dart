import 'package:flutter/material.dart';
import 'package:getpay_merchant_app/common/constants/route_strings.dart';
import 'package:getpay_merchant_app/dashboard/presentation/dashboard_page.dart';
import 'package:getpay_merchant_app/login/presentation/login_page.dart';
import 'package:getpay_merchant_app/otp/presentation/otp_page.dart';
import 'package:getpay_merchant_app/signup/presentation/sign_up_details_page.dart';

class RouteHandler{
  static Route<dynamic> generateRoute(RouteSettings settings){
    var arg= settings.arguments;

    switch(settings.name){
      case RouteStrings.loginPage:
        return MaterialPageRoute(builder: (_)=> LoginPage());
      case RouteStrings.signupPage:
        return MaterialPageRoute(builder: (_)=> SignUpPage());
      case RouteStrings.otpPage:
        return MaterialPageRoute(builder: (_)=> OtpPage());
      case RouteStrings.dashboardPage:
        return MaterialPageRoute(builder: (_)=> DashboardPage());
        
      default:
        return MaterialPageRoute(builder: (_)=> Container(
          child: Center(
            child: Text('404'),
          ),
        ),);
    }
  }
}