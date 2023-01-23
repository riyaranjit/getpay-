// import 'package:dynamic_form/config/app_colors.dart';
// import 'package:flutter/material.dart';
//
// class CustomAppBar extends StatelessWidget {
//   Widget? leading;
//   String? title;
//   bool showBackButton;
//   double? elevation;
//   List<Widget>? trailing;
//
//   CustomAppBar({
//     Key? key,
//     this.leading,
//     this.title,
//     this.showBackButton = true,
//     this.elevation = 0.0,
//     this.trailing,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:  Center(
//         child: Text(
//           "title" ?? "",
//           style: TextStyle(
//             fontSize: 18.0,
//             color: AppColors.black,
//           ),
//         ),
//       ),
//     );

import 'package:dynamic_form/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  Widget? leading;
  String? title;
  bool showBackButton;
  double? elevation;
  List<Widget>? trailing;

  CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.showBackButton = true,
    this.elevation = 0.0,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      leading: leading,
      elevation: elevation,
      title: Text(
        title ?? "",
        style: TextStyle(
          fontSize: 20.0,
          color: AppColors.getPayBlue,
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.getPayLightBlue,
      ),
      actions: trailing,
    );
  }
}
