import 'package:dynamic_form/models/selectable.dart';
import 'package:flutter/cupertino.dart';

class KycField {
  String title;
  String code;
  List<DynamicField> dynamicFields;

  KycField({this.title, this.code, this.dynamicFields});

  KycField.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    code = json['code'];
    if (json['fields'] != null) {
      dynamicFields = new List<DynamicField>();
      json['fields'].forEach((v) {
        dynamicFields.add(new DynamicField.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['code'] = this.code;
    if (this.dynamicFields != null) {
      data['fields'] = this.dynamicFields.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DynamicField {
  String imageSource;
  DataType dataType;
  Constraints constraints;
  String title;
  String code;
  String value;
  Values values;
  List<String> source;
  double minQueryLength;
  TextInputType keyboardType;

  DynamicField({
    this.dataType,
    this.constraints,
    this.title,
    this.code,
    this.value,
    this.values,
    this.imageSource,
    this.source,
    this.minQueryLength,
    this.keyboardType = TextInputType.text,
  });

  DynamicField.forSpinner(
      this.imageSource,
      this.dataType,
      this.constraints,
      this.title,
      this.code,
      this.value,
      this.values,
      this.source,
      this.minQueryLength,
      this.keyboardType);

  DynamicField.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'] != null
        ? new DataType.fromJson(json['dataType'])
        : null;
    constraints = json['constraints'] != null
        ? new Constraints.fromJson(json['constraints'])
        : null;
    title = json['title'];
    code = json['code'];
    value = json['value'];
    values =
        json['values'] != null ? new Values.fromJson(json['values']) : null;
    source = json['source'] != null ? json['source'].cast<String>() : null;
    imageSource = json['imageSource'];
    minQueryLength = json['minQueryLength'];
    keyboardType = json['keyboardType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataType != null) {
      data['dataType'] = this.dataType.toJson();
    }
    if (this.constraints != null) {
      data['constraints'] = this.constraints.toJson();
    }
    data['title'] = this.title;
    data['code'] = this.code;
    data['value'] = this.value;
    if (this.values != null) {
      data['values'] = this.values.toJson();
    }
    data['source'] = this.source;
    data['imageSource'] = this.imageSource;
    data['minQueryLength'] = this.minQueryLength;
    data['keyboardType'] = this.keyboardType;
    return data;
  }
}

class DataType {
  String type;
  Format format;

  DataType({this.type, this.format});

  DataType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    format =
        json['format'] != null ? new Format.fromJson(json['format']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.format != null) {
      data['format'] = this.format.toJson();
    }
    return data;
  }
}

class Format {
  String formatter;
  bool allowPast;
  bool allowFuture;
  bool allowPresent;
  List<String> displayCalendar;

  Format(
      {this.formatter,
      this.allowPast,
      this.allowFuture,
      this.allowPresent,
      this.displayCalendar});

  Format.fromJson(Map<String, dynamic> json) {
    formatter = json['formatter'];
    allowPast = json['allowPast'];
    allowFuture = json['allowFuture'];
    allowPresent = json['allowPresent'];
    displayCalendar = json['displayCalendar'] != null
        ? json['displayCalendar'].cast<String>()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatter'] = this.formatter;
    data['allowPast'] = this.allowPast;
    data['allowFuture'] = this.allowFuture;
    data['allowPresent'] = this.allowPresent;
    data['displayCalendar'] = this.displayCalendar;
    return data;
  }
}

class Constraints {
  Size size;
  bool required;
  bool readonly;
  bool hidden;
  List<Criteria> visibleWhen;
  List<Criteria> requiredWhen;
  List<Criteria> conditionCriterias;

  Constraints(
      {this.size,
      this.required = false,
      this.readonly = false,
      this.hidden = false,
      this.visibleWhen,
      this.requiredWhen,
      this.conditionCriterias});

  Constraints.fromJson(Map<String, dynamic> json) {
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    required = json['required'];
    readonly = json['readonly'];
    hidden = json['hidden'];
    if (json['visibleWhen'] != null) {
      visibleWhen = new List<Criteria>();
      json['visibleWhen'].forEach((v) {
        visibleWhen.add(new Criteria.fromJson(v));
      });
    }
    if (json['requiredWhen'] != null) {
      requiredWhen = new List<Criteria>();
      json['requiredWhen'].forEach((v) {
        requiredWhen.add(new Criteria.fromJson(v));
      });
    }
    if (json['conditionCriterias'] != null) {
      conditionCriterias = new List<Criteria>();
      json['conditionCriterias'].forEach((v) {
        conditionCriterias.add(new Criteria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.size != null) {
      data['size'] = this.size.toJson();
    }
    data['required'] = this.required;
    data['readonly'] = this.readonly;
    data['hidden'] = this.hidden;
    if (this.visibleWhen != null) {
      data['visibleWhen'] = this.visibleWhen.map((v) => v.toJson()).toList();
    }
    if (this.requiredWhen != null) {
      data['requiredWhen'] = this.requiredWhen.map((v) => v.toJson()).toList();
    }
    if (this.conditionCriterias != null) {
      data['conditionCriterias'] =
          this.conditionCriterias.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Criteria {
  String fieldName;
  String condition;
  String fromValue;
  String setValue;

  Criteria({this.fieldName, this.condition, this.fromValue, this.setValue});

  Criteria.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    condition = json['condition'];
    fromValue = json['fromValue'];
    setValue = json['setValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['condition'] = this.condition;
    data['fromValue'] = this.fromValue;
    data['setValue'] = this.setValue;
    return data;
  }
}

class Size {
  double minimum;
  double maximum;

  Size({this.minimum, this.maximum});

  Size.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    return data;
  }
}

class Values {
  String dataSource;
  String filterKey;
  String filterValue;
  List<Selectable> data;
  Map<String, dynamic> payload;

  Values(
      {this.dataSource,
      this.filterKey,
      this.filterValue,
      this.data,
      this.payload});

  Values.fromJson(Map<String, dynamic> json) {
    dataSource = json['dataSource'];
    filterKey = json['filterKey'];
    filterValue = json['filterValue'];
    if (json['data'] != null) {
      data = new List<Selectable>();
      json['data'].forEach((v) {
        data.add(new Selectable.fromJson(v));
      });
    }
    payload = json['payload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataSource'] = this.dataSource;
    data['filterKey'] = this.filterKey;
    data['filterValue'] = this.filterValue;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['payload'] = this.payload;
    return data;
  }
}
