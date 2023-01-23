import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:getpay_merchant_app/common/constants/app_bar_height.dart';
import 'package:getpay_merchant_app/common/widgets/getpay_base_page.dart';
import 'package:getpay_merchant_app/common/widgets/widget_utils.dart';
import 'package:getpay_merchant_app/signup/presentation/sign_up_details_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String? otp;

  @override
  Widget build(BuildContext context) {
    return GetPayBasePage(
      alignment: "top",
      appBarHeight: getAppBarHeight(context),
      appBar: customAppBar("Verify Numbers", context),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              verticalMargin(20.0),
              Image.asset(
                "assets/images/img.png",
                height: 80.0,
                width: 60.0,
              ),
              verticalMargin(20.0),
              const Text(
                "Please Enter the OTP",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              verticalMargin(14.0),
              const Text(
                "A code has been sent to your Email/Phone number. Please enter the code.",
                style: TextStyle(),textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal:15.0 ),
                child: PinCodeTextField(
                  cursorColor: AppColors.getPayBlue,
                    blinkWhenObscuring: false,
                    animationDuration: Duration(milliseconds: 10),
                    appContext: context,
                    length: 6,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(4.0),
                      fieldHeight: 45,
                      fieldWidth: 45,
                      inactiveColor: AppColors.grey,
                      activeColor: AppColors.getPayBlue,
                      selectedColor: AppColors.getPayBlue
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                    otp= value;
                    }),
              ),
              verticalMargin(14.0),
              Text("Didn't get the code we sent you?"),
              TextButton(onPressed: (){}, child: Text("Resend Code")),
              verticalMargin(35.0),
              CustomButton(
                title: "Verify",
                width: 200.0,
                onButtonTapped: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
