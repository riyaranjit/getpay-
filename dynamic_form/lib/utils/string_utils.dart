const String placeholderPattern = '(\{([a-zA-Z0-9]+)\})';

String getUserId(String prefValue) {
  if (prefValue == null) {
    return "";
  }
  var splittedValue = prefValue.split(',');
  var userName = splittedValue[0];
  return userName;
}

String dateTimeToString(DateTime date) {
  String YYYY = date.year.toString();
  String MM = date.month.toString();
  if (MM.length < 2) MM = "0" + MM;
  String DD = date.day.toString();
  if (DD.length < 2) DD = "0" + DD;
  return YYYY + "-" + MM + "-" + DD;
}

DateTime getDateTimeFromString(String stringDate) {
  var splittedDate = stringDate.split('-');
  int year = int.parse(splittedDate[0]);
  int month = int.parse(splittedDate[1]);
  int day = int.parse(splittedDate[2]);
  return DateTime.utc(year, month, day);
}

String getMMDDYYYYDate(String date) {
  var splittedDate = date.split('-');
  return splittedDate[1]+"-"+splittedDate[2]+"-"+splittedDate[0];
}

String replaceVariable(String template, List replacements) {
  var regExp = RegExp(placeholderPattern);
  if(regExp.allMatches(template).length == replacements.length) {
    for (var replacement in replacements) {
      template = template.replaceFirst(regExp, replacement.toString());
    }
  }
  return template;
}
