import 'package:dynamic_form/components/field_component.dart';
import 'package:dynamic_form/form/calendar_type.dart';
import 'package:dynamic_form/form/validation_rule.dart';
import 'package:dynamic_form/models/dynamic_field.dart';

class DateFieldComponent extends FieldComponent {
  DateRange dateRange;
  String dateFormatter;
  CalendarType calendarType;
  bool allowPresentDate;

  DateFieldComponent(DynamicField element)
      : super(element, validationRule: ValidationRule.generalTextRule()) {
    this.dateRange = getDateRange(element);
    this.dateFormatter = element.dataType.format.formatter;
    this.calendarType = getCalendarType(element);
    this.allowPresentDate = element.dataType.format.allowPresent;
  }
}

getDateRange(DynamicField element) {
  if (element.dataType.format.allowPast) {
    return DateRange.PAST;
  } else if (element.dataType.format.allowFuture) {
    return DateRange.FUTURE;
  } else {
    return DateRange.ALL;
  }
}

getCalendarType(DynamicField element) {
  List<String> displayCalendar = element.dataType.format.displayCalendar;
  displayCalendar.forEach((element) {
    element.toUpperCase();
  });
  if (displayCalendar.contains("BS"))
    return CalendarType.BS;
  else
    return CalendarType.AD;
}
