import 'package:dynamic_form/config/app_colors.dart';
import 'package:flutter/material.dart';
import '../../config/app_styles.dart';
import '../../utils/dynamic_form_style.dart';


enum FieldType {
  password,
  email,
  username,
  phone,
  text,
  datepicker,
  country,
  imageUpload,
  dropdown,
  checkBox,
  switchs
}


class CustomFormField extends StatefulWidget {
  final String label;
  final bool? enabled;
  final String? labelText;
  final String hintText;
  final Widget? prefixIcon;
  final FieldType fieldType;
  final TextEditingController? controller;
  String? initialValue;
  final bool? isRequired;
  final bool? isDynamicForm;
  VoidCallback? onTap;
  Function(dynamic)? onFieldSubmitted;
  bool isObscure;
  Function(String)? onChanged;
  Function(String?)? onSaved;
  List? options;
  double? borderRadius;

  CustomFormField(
      {Key? key,
        required this.label,
        required this.hintText,
        this.labelText,
        this.prefixIcon,
        this.isRequired,
        this.onChanged,
        this.enabled,
        this.initialValue,
        this.onTap,
        required this.fieldType,
        this.controller,
        this.onSaved,
        this.isDynamicForm,
        this.onFieldSubmitted,
        this.options,
        this.borderRadius,
        this.isObscure = true})
      : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    widget.isDynamicForm == null ? false : true;
    return  Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
        child: checkWidgetType());
  }

  Widget checkWidgetType(){
    if( widget.fieldType== FieldType.text){
      return textFieldWidget();
    }else if( widget.fieldType== FieldType.dropdown){
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
                // style: BorderStyle.solid
              ),
              borderRadius: BorderRadius.circular(10)),
          child: widget.options!.length > 10
              ? GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.controller!.text == ""
                      ? ""
                      : getDropDownLabel(
                      widget.controller!.text.toString())),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),

          )
              : GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.controller!.text == ""
                      ? ""
                      : getDropDownLabel(
                      widget.controller!.text.toString())),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            // onTap: () {
            //   showModalBottomSheet(
            //       context: context,
            //       builder: (context) {
            //         return SizedBox(
            //           height: 300,
            //           child: CustomSearchListView(
            //               options: widget.options!.toList(),
            //               title: widget.labelText.toString(),
            //               onSelect: (Map val) {
            //                 setState(() {
            //                   widget.controller!.text = val["value"];
            //                   widget.onFieldSubmitted!
            //                       .call(getDropDownValue(val["value"]));
            //                 });
            //               }),
            //         );
            //       });
            // },
          ));
    }
    return textFieldWidget();
  }

  textFieldWidget() {
    return TextFormField(
      enabled: widget.enabled,
      onTap: widget.onTap,
      onChanged: widget.isDynamicForm == true
          ? (val) {
        widget.onFieldSubmitted?.call(val);
      }
          : widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: (value) {
        return widget.isDynamicForm == true
            ? checkDynamicValidation(
            value.toString(), widget.isRequired as bool)
            : checkValidation(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText:
      widget.fieldType == FieldType.password ? widget.isObscure : false,
      keyboardType: checkKeyboardType(),
      readOnly: widget.fieldType == FieldType.country ? true : false,

      decoration: InputDecoration(
        suffixIcon: widget.fieldType == FieldType.password
            ? IconButton(
          icon: Icon(
              widget.isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              widget.isObscure = widget.isObscure ? false : true;
            });
          },
        )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.borderRadius!)),
        prefixIcon: widget.prefixIcon,
        //labelText: widget.labelText,
        hintText: widget.hintText,
      ),

    );
  }

  checkDynamicValidation(String value, bool isRequired) {
    if (value == "" && isRequired == true) {
      return "${widget.label} cannot be empty.";
    }
  }

  validateEmail(String email) {
    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    }
    return false;
  }

  TextInputType checkKeyboardType() {
    if (widget.fieldType == FieldType.email) {
      return TextInputType.emailAddress;
    } else if (widget.fieldType == FieldType.phone) {
      return TextInputType.phone;
    } else {
      return TextInputType.text;
    }
  }

  checkValidation(String? controller) {
    var selectedEnumField = widget.fieldType;
    if (controller == null || controller.isEmpty) {
      switch (selectedEnumField) {
        case FieldType.email:
          return 'Please enter your email address';

        case FieldType.password:
          return 'Please enter your password';

        case FieldType.datepicker:
          return 'Please enter date';
        case FieldType.country:
          return 'Please Select Valid Country';

        case FieldType.text:
          return null;

        default:
          return 'Please enter valid details.';
      }
    } else if (controller.length < 4 &&
        selectedEnumField == FieldType.username) {
      return 'Username should be more than 3 character';
    } else if (controller.length < 6 &&
        selectedEnumField == FieldType.password) {
      return 'Password should be at least 6 character';
    } else if (selectedEnumField == FieldType.email &&
        !validateEmail(controller)) {
      return 'Please enter valid email.';
    } else if (controller.length < 10 && selectedEnumField == FieldType.phone) {
      return 'Please enter 10 digit number';
    } else if (selectedEnumField == FieldType.text &&
        widget.isRequired == false) {
      return null;
    } else {
      return null;
    }
  }

  String getDropDownLabel(String initialVal) {
    widget.options!.forEach(
          (e) {
        if (e['value'] == initialVal) {
          setState(() {
            widget.controller!.text = e['label'];
          });
        }
      },
    );
    return widget.controller!.text;
  }

  String getDropDownValue(String initialVal) {
    widget.options!.forEach(
          (e) {
        if (e['label'] == initialVal) {
          setState(() {
            widget.controller!.text = e['value'];
          });
        }
      },
    );
    return widget.controller!.text;
  }

}






























//
// class CustomTextFormField extends StatelessWidget {
//   IconData? icon;
//   String? hintText;
//   String? labelText;
//   String? errorText = null;
//   TextEditingController? controller;
//   TextInputType? keyboardType = TextInputType.text;
//   int? maxLength = 10;
//
//   CustomTextFormField(
//       {Key? key,
//       this.hintText,
//       this.icon,
//       this.labelText,
//       this.errorText,
//       this.controller,
//       this.keyboardType,
//       this.maxLength})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.tertiary,
//           borderRadius: BorderRadius.all(
//               Radius.circular(MediaQuery.of(context).size.height * 0.01))),
//       child: TextFormField(
//         controller: controller,
//         maxLength: maxLength,
//         decoration: getInputDecoration(icon),
//         keyboardType: keyboardType,
//       ),
//     );
//   }
//
//   getInputDecoration(IconData? iconData) {
//     return InputDecoration(
//         contentPadding:
//             EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0, right: 16.0),
//         prefixIcon: iconData == null
//             ? null
//             : Padding(
//                 padding: EdgeInsets.only(left: 8.0, right: 8.0),
//                 child: Icon(
//                   iconData,
//                   size: 18.0,
//                 ),
//               ),
//         suffixIcon: iconData == null
//             ? null
//             : Padding(
//                 padding: EdgeInsets.only(left: 8.0, right: 8.0),
//                 child: Icon(
//                   iconData,
//                   size: 18.0,
//                 ),
//               ),
//         fillColor: Colors.white,
//         filled: true,
//         errorMaxLines: 1,
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.grey, width: 1.0),
//             borderRadius: DynamicFormStyle.dynamicFieldBorderRadius),
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.grey, width: 1.0),
//             borderRadius: DynamicFormStyle.dynamicFieldBorderRadius),
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.grey, width: 1.0),
//             borderRadius: DynamicFormStyle.dynamicFieldBorderRadius),
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.grey, width: 1.0),
//             borderRadius: DynamicFormStyle.dynamicFieldBorderRadius),
//         border: InputBorder.none,
//         labelText: hintText,
//         labelStyle: normalTextStyle(color: AppColors.grey),
//         // counterText: "",
//         hintStyle: normalTextStyle(color: AppColors.grey));
//   }
// }
