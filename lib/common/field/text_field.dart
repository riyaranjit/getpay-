import 'package:flutter/material.dart';

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
        this.isObscure = true})
      : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  dynamic imagefile;
  bool switchStatus = false;
  void initState() {
    super.initState();
    if (widget.fieldType == FieldType.imageUpload)
      showImage(widget.controller?.text.toString());
    if (widget.fieldType == FieldType.switchs) {
      widget.controller!.text == "true" ? switchStatus = true : false;
      applog(switchStatus);
    }
  }

  Future<dynamic> navigatedReturnedValue(BuildContext context) async {
    final result =
    await Navigator.pushNamed(context, RoutePaths.countryListPage);
    if (result != null) {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.isDynamicForm == null ? false : true;
    return Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
        child: checkWidgetType());
  }

  Future showImage(image) async {
    final imageRepo = await GetIt.instance.get<ImageRepository>();

    await imageRepo.getImage(image).then((value) {
      if (value != null) {
        if (mounted)
          setState(() {
            imagefile = value;
          });
      }
    });
    return imagefile;
  }

  Widget checkWidgetType() {
    if (widget.fieldType == FieldType.imageUpload) {
      return InkWell(
        onTap: () async {
          final imageRepo = await GetIt.instance.get<ImageRepository>();
          await customImagePicker().then((value) => {
            imageRepo.uploadCustomerImg().then((val) {
              imageRepo.uploadMinioProfileImg(value, val['url']);
              setState(() {
                imagefile = value;
                // widget.controller!.text = val['minio_id'];
                widget.onFieldSubmitted?.call(val['minio_id']);
              });
            }),
          });
        },
        child: Container(
          height: 100,
          width: 90,
          child: imagefile == null
              ? Center(child: CircularProgressIndicator())
              : imagefile is File
              ? Image.file(imagefile)
              : Image.network(
            imagefile.toString(),
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        ),
      );
    } else if (widget.fieldType == FieldType.dropdown) {
      // String selectedValue = widget.controller!.text;
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.darkGreyColor,
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
            onTap: () {
              Navigator.pushNamed(
                  context, RoutePaths.customSearchListView, arguments: {
                'options': widget.options,
                'label': widget.labelText,
                'showSearch': true
              }).then((value) {
                setState(() {
                  Map? val = value as Map;
                  if (value == null) {
                    widget.controller!.text =
                        widget.initialValue.toString();
                    widget.onFieldSubmitted!
                        .call(widget.initialValue.toString());
                  } else {
                    widget.controller!.text = val['label'];
                    widget.onFieldSubmitted!.call(val['value']);
                  }
                });
              });
            },
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
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 300,
                      child: CustomSearchListView(
                          options: widget.options!.toList(),
                          title: widget.labelText.toString(),
                          onSelect: (Map val) {
                            setState(() {
                              widget.controller!.text = val["value"];
                              widget.onFieldSubmitted!
                                  .call(getDropDownValue(val["value"]));
                            });
                          }),
                    );
                  });
            },
          )

        // : DynamicFieldDropDown(
        //     initialValue: widget.initialValue == null
        //         ? widget.options!.first['label']
        //         : getDropDownLabel(widget.controller!.text.toString()),
        //     getSelectedValue: (val) {
        //       setState(() {
        //         widget.controller!.text = val;
        //         widget.onFieldSubmitted!.call(getDropDownValue(val));
        //       });
        //     },
        //     dropDownListData: widget.options as List),
      );
    } else if (widget.fieldType == FieldType.text) {
      return textFieldWidget();
    } else if (widget.fieldType == FieldType.datepicker) {
      return widget.controller!.text == ""
          ? TextFormField(
        decoration: InputDecoration(
          label: Text('Please select a date'),
          suffixIcon: IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.parse(widget.controller!.text == ""
                    ? DateTime.now().toString()
                    : widget.controller!.text),
                lastDate: DateTime.utc(2030),
                firstDate: DateTime.utc(1990),
              ).then((value) {
                String pickedDate = DateFormat("yyyy-MM-dd").format(
                    value ??
                        DateTime.parse(
                            widget.controller!.text.toString()));
                setState(() {
                  widget.controller?.text = pickedDate.toString();
                  widget.onFieldSubmitted!.call(pickedDate);
                });
              });
            },
          ),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: widget.prefixIcon,
          //labelText: widget.labelText,
          hintText: widget.hintText,
        ),
      )
          : Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.darkGreyColor,
                width: 1,
                // style: BorderStyle.solid
              ),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.parse(widget.controller!.text == ""
                    ? DateTime.now().toString()
                    : widget.controller!.text),
                lastDate: DateTime.utc(2030),
                firstDate: DateTime.utc(1990),
              ).then((value) {
                String pickedDate = DateFormat("yyyy-MM-dd").format(value ??
                    DateTime.parse(widget.controller!.text.toString()));
                if (widget.labelText == "Date of Birth") {
                  if (isAdult(value.toString()) < 18) {
                    setState(() {
                      widget.controller?.text = widget.controller!.text;
                      widget.onFieldSubmitted!
                          .call(widget.controller?.text);
                    });
                    return showConfirmDialog(
                        context,
                        'Unable to select date',
                        Text(
                            'Your age should be at least 18 years for registration.\n please choose different age.'));
                    // showErrorToast("You are under age");
                  }
                  setState(() {
                    widget.controller?.text = pickedDate.toString();
                    widget.onFieldSubmitted!.call(pickedDate);
                  });
                }
                setState(() {
                  widget.controller?.text = pickedDate.toString();
                  widget.onFieldSubmitted!.call(pickedDate);
                });
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.date_range),
                  SizedBox(
                    width: 20,
                  ),
                  Text(widget.controller!.text.toString()),
                ],
              ),
            ),
          ));
    } else if (widget.fieldType == FieldType.switchs) {
      // switchStatus = widget.controller?.text == 'true'? true: false;

      return Switch(value: switchStatus, onChanged: toggleSwitch);
    }
    return textFieldWidget();
  }

  void toggleSwitch(bool value) {
    if (switchStatus == false) {
      setState(() {
        switchStatus = true;
        widget.controller!.text == 1;
        widget.onFieldSubmitted!.call(1);
      });
    } else {
      setState(() {
        switchStatus = false;
        widget.controller!.text == 0;
        widget.onFieldSubmitted!.call(0);
      });
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

  double isAdult(String enteredAge) {
    var birthDate = DateTime.parse(enteredAge);
    print("set state: $birthDate");
    var today = DateTime.now();

    final difference = today.difference(birthDate).inDays;
    print(difference);
    final year = difference / 365;
    print(year);
    return year;
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: widget.prefixIcon,
        //labelText: widget.labelText,
        hintText: widget.hintText,
      ),
    );
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
}
