import 'package:flutter/material.dart';
import 'package:getpay_merchant_app/common/field/custom_text_form_field.dart';
import 'package:getpay_merchant_app/common/widgets/getpay_base_page.dart';

import '../../common/constants/app_bar_height.dart';
import '../../common/widgets/widget_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return GetPayBasePage(
      alignment: "top",
      appBarHeight: getAppBarHeight(context),
      appBar: customAppBar("Verify Numbers", context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [CustomFormField(label: "label", hintText: "Username", fieldType: FieldType.email, prefixIcon: Icon(Icons.lock_person), borderRadius: 18.0,) ],
        ),
      ),
    );

  }
}
