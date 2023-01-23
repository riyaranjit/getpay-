import 'package:calendarro/date_utils.dart' as calendar;
import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/datepicker/custom_switch.dart';
import 'package:dynamic_form/form/calendar_type.dart';
import 'package:dynamic_form/utils/log_utils.dart';
import 'package:dynamic_form/utils/widget_utils.dart';
import 'package:dynamic_form/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'nepali_date_converter.dart';

class DateMitiPicker extends StatefulWidget {
  Function(String bs, String ad) onDateSelected;
  String title;
  DateRange dateRange;
  String initialDate;
  CalendarType calendarType;
  bool allowPresentDate;

  DateMitiPicker(
      {this.onDateSelected,
      this.title,
      this.dateRange,
      this.initialDate,
      this.allowPresentDate = true,
      this.calendarType = CalendarType.BS});

  @override
  _DateMitiPickerState createState() => _DateMitiPickerState();
}

class _DateMitiPickerState extends State<DateMitiPicker> {
  List<int> yearList = List();
  List<String> monthList = List();
  List<int> daysList = List();
  int selectedYearIndex = 0;
  int selectedMonthIndex = 0;
  int selectedDayIndex = 0;
  FixedExtentScrollController yearController;
  FixedExtentScrollController monthController;
  FixedExtentScrollController dayController;
  final double SPACING = 8.0;
  final double PICKER_HEIGHT = 150.0;
  final double ITEM_HEIGHT = 50.0;
  final bool LOOPING = true;
  final cupertinoThemeData = CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
          pickerTextStyle: TextStyle(color: colorPrimary, fontSize: 18),
          tabLabelTextStyle: TextStyle(color: AppColors.grey, fontSize: 1.0)));
  CalendarType calendarType;
  DateTime todayAdDate = DateTime.now().toUtc();
  DateTime todayBsDate;

  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    appLog("initial date got: ${widget.initialDate}");
    todayAdDate =
        DateTime.utc(todayAdDate.year, todayAdDate.month, todayAdDate.day);
    todayBsDate = NepaliDateConverter.getDateTimeFromString(
        NepaliDateConverter.convertADToBS(
            todayAdDate.year, todayAdDate.month, todayAdDate.day));
    calendarType = widget.calendarType;
    initInitialDateIfEmpty();
    if (calendarType == CalendarType.BS) {
      initializeBSYear();
      initializeBSMonth();

      int initialYear = yearList.asMap().keys.firstWhere((element) =>
          yearList.asMap()[element] ==
          NepaliDateConverter.getYearFromDate(widget.initialDate));

      appLog("year index: $selectedYearIndex");

      int initialMonth =
          NepaliDateConverter.getMonthFromDate(widget.initialDate) - 1;

      generateDaysList(initialYear, initialMonth);
    } else {
      initializeADYear();
      initializeADMonth();

      int initialYear = yearList.asMap().keys.firstWhere((element) =>
          yearList.asMap()[element] ==
          NepaliDateConverter.getYearFromDate(widget.initialDate));
      int initialMonth =
          NepaliDateConverter.getMonthFromDate(widget.initialDate) - 1;
      generateADDay(DateTime.utc(initialYear, initialMonth));
    }

    yearController = FixedExtentScrollController();
    monthController = FixedExtentScrollController();
    dayController = FixedExtentScrollController();

    setInitialDate();
    checkDateRange();
  }

  _buildYearSpinner() {
    return CupertinoTheme(
      data: cupertinoThemeData,
      child: Container(
        height: PICKER_HEIGHT,
        child: CupertinoPicker(
          scrollController: yearController,
          itemExtent: ITEM_HEIGHT,
          looping: LOOPING,
          backgroundColor: AppColors.white,
          onSelectedItemChanged: (index) {
            setState(() {
              appLog("Trigger from year");
              selectedYearIndex = index;
              updateDaysList(selectedYearIndex, selectedMonthIndex);
              checkDateRange();
            });
          },
          children: _buildYearListWidget(),
        ),
      ),
    );
  }

  _buildMonthSpinner() {
    return CupertinoTheme(
      data: cupertinoThemeData,
      child: Container(
        height: PICKER_HEIGHT,
        child: CupertinoPicker(
          scrollController: monthController,
          itemExtent: ITEM_HEIGHT,
          looping: LOOPING,
          backgroundColor: AppColors.white,
          onSelectedItemChanged: (index) {
            appLog("Trigger from month");
            selectedMonthIndex = index;
            updateDaysList(selectedYearIndex, selectedMonthIndex);
            checkDateRange();
          },
          children: _buildMonthListItems(),
        ),
      ),
    );
  }

  _buildDateSpinner() {
    return CupertinoTheme(
      data: cupertinoThemeData,
      child: Container(
        height: PICKER_HEIGHT,
        child: CupertinoPicker(
          scrollController: dayController,
          itemExtent: ITEM_HEIGHT,
          looping: LOOPING,
          backgroundColor: AppColors.white,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedDayIndex = index;
              checkDateRange();
            });
          },
          children: _buildDaysListItems(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    appLog("Building Calendar");
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(color: colorPrimary, fontSize: 22),
                  ),
                  Visibility(
                    visible: true,
                    child: CustomSwitch(
                      initialCalendarType: widget.calendarType,
                      onBSTapped: () {
                        appLog("bs tapped");
                        setState(() {
                          calendarType = CalendarType.BS;
                          convertCurrentDateToBS();
                        });
                      },
                      onADTapped: () {
                        calendarType = CalendarType.AD;
                        convertCurrentDateToAD();
                      },
                    ),
                  )
                ],
              ),
              verticalMargin(10),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildYearSpinner(),
                    ),
                    horizontalMargin(SPACING),
                    Expanded(child: _buildMonthSpinner()),
                    horizontalMargin(SPACING),
                    Expanded(child: _buildDateSpinner()),
                  ],
                ),
              ),
              Visibility(
                visible: hasError,
                child: Text(
                  errorMessage,
                  style: TextStyle(color: AppColors.red, fontSize: 14.0),
                ),
              ),
              verticalMargin(10),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  onButtonTapped: () {
                    String BS;
                    String AD;
                    if (calendarType == CalendarType.BS) {
                      String YYYY = "${yearList[selectedYearIndex]}";
                      String MM = "${selectedMonthIndex + 1}";
                      if (MM.length < 2) MM = "0" + MM;
                      String DD = "${selectedDayIndex + 1}";
                      if (DD.length < 2) DD = "0" + DD;
                      BS = YYYY + "-" + MM + "-" + DD;
                      DateTime date = NepaliDateConverter.convertBSToAD(
                          yearList[selectedYearIndex],
                          selectedMonthIndex + 1,
                          selectedDayIndex + 1);
                      AD = NepaliDateConverter.dateTimeToString(date);
                    } else if (calendarType == CalendarType.AD) {
                      String YYYY = "${yearList[selectedYearIndex]}";
                      String MM = "${selectedMonthIndex + 1}";
                      if (MM.length < 2) MM = "0" + MM;
                      String DD = "${selectedDayIndex + 1}";
                      if (DD.length < 2) DD = "0" + DD;
                      AD = YYYY + "-" + MM + "-" + DD;
                      BS = NepaliDateConverter.convertADToBS(
                          yearList[selectedYearIndex],
                          selectedMonthIndex + 1,
                          selectedDayIndex + 1);
                    }
                    widget.onDateSelected(BS, AD);
                  },
                  title: "done",
                  textColor: AppColors.black,
                  clickable: !hasError,
                  width: null,
                ),
              ),
              verticalMargin(10)
            ],
          ),
        ),
      ),
    );
  }

  _buildYearListWidget() {
    List<Widget> yearListWidgets = List();
    for (var i = 0; i < yearList.length; i++) {
      yearListWidgets.add(Center(
          child: Text(
        yearList[i].toString(),
        style: selectedYearIndex == i
            ? TextStyle(color: colorPrimary)
            : TextStyle(color: AppColors.grey),
      )));
    }
    return yearListWidgets;
  }

  _buildMonthListItems() {
    List<Widget> monthListItems = List();
    for (var i = 0; i < monthList.length; i++) {
      monthListItems.add(Center(
          child: Text(
        monthList[i].toString(),
        style: selectedMonthIndex == i
            ? TextStyle(color: colorPrimary)
            : TextStyle(color: AppColors.grey),
      )));
    }
    return monthListItems;
  }

  _buildDaysListItems() {
    List<Widget> dayListItems = List();
    for (var i = 0; i < daysList.length; i++) {
      dayListItems.add(Center(
          child: Text(
        daysList[i].toString(),
        style: selectedDayIndex == i
            ? TextStyle(color: colorPrimary)
            : TextStyle(color: AppColors.grey),
      )));
    }
    return dayListItems;
  }

  List<int> generateDaysList(int yearIndex, int monthIndex) {
    daysList.clear();
    var maxDaysInMonth =
        NepaliDateConverter.nepaliMap[yearList[yearIndex]][monthIndex + 1];
    for (int i = 1; i <= maxDaysInMonth; i++) {
      daysList.add(i);
    }
  }

  List<int> updateDaysList(int yearIndex, int monthIndex) {
    appLog("UPDATE TRIGGER $yearIndex $monthIndex");
    daysList.clear();
    if (calendarType == CalendarType.BS) {
      var maxDaysInMonth =
          NepaliDateConverter.nepaliMap[yearList[yearIndex]][monthIndex + 1];

      for (int i = 1; i <= maxDaysInMonth; i++) {
        daysList.add(i);
      }
      if (selectedDayIndex + 1 > maxDaysInMonth) {
        selectedDayIndex = maxDaysInMonth - 1;
      }
      dayController.animateToItem(selectedDayIndex,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
      setState(() {});
    } else {
      DateTime dateForGettingDay =
          DateTime(yearList[yearIndex], monthIndex + 1); //Month start from 1
      appLog("Date for gettingDay: $dateForGettingDay");
      DateTime lastDayofMonth =
          calendar.DateUtils.getLastDayOfMonth(dateForGettingDay);
      int maxDayInMonth = lastDayofMonth.day;
      for (int i = 1; i <= maxDayInMonth; i++) {
        daysList.add(i);
      }

      if (selectedDayIndex + 1 > maxDayInMonth) {
        selectedDayIndex = maxDayInMonth - 1;
      }
      dayController.animateToItem(selectedDayIndex,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
      setState(() {});
    }
  }

  void convertCurrentDateToBS() {
    var result = NepaliDateConverter.convertADToBS(
        yearList[selectedYearIndex],
        NepaliDateConverter.englishMonth.keys.firstWhere((element) =>
            NepaliDateConverter.englishMonth[element] ==
            monthList[selectedMonthIndex]),
        daysList[selectedDayIndex]);
    if (result == DATE_LIMIT_CROSSED) {
      showToast("Maximum date limit reached!"); //todo
      changeCurrentCalendarTOBS("1970-01-01");
    } else {
      changeCurrentCalendarTOBS(result);
    }
  }

  void convertCurrentDateToAD() {
    var result = NepaliDateConverter.convertBSToAD(
        yearList[selectedYearIndex],
        NepaliDateConverter.nepaliMonth.keys.firstWhere((element) =>
            NepaliDateConverter.nepaliMonth[element] ==
            monthList[selectedMonthIndex]),
        daysList[selectedDayIndex]);

    appLog("result: $result");
    if (result.isAfter(DateTime.now())) {
      showToast("Maximum date limit reached!");
      changeCurrentCalendarTOAD(DateTime(1913, 1, 1));
    } else {
      changeCurrentCalendarTOAD(result);
    }
  }

  void changeCurrentCalendarTOBS(String dateTime) {
    generateBSDay(dateTime);
    initializeBSYear();
    initializeBSMonth();
    var splittedDate = dateTime.split('-');
    var year = splittedDate[0];
    var month = splittedDate[1];
    var day = splittedDate[2];

    appLog("BS CANVAS FILLED");
    setState(() {
      selectedYearIndex = yearList.asMap().keys.firstWhere(
          (element) => yearList.asMap()[element] == int.parse(year));

      appLog("year index: $selectedYearIndex");

      selectedMonthIndex = monthList.asMap().keys.firstWhere((element) =>
          NepaliDateConverter.nepaliMonth[element] ==
          NepaliDateConverter.nepaliMonth[int.parse(month) - 1]);

      appLog("month index: $selectedMonthIndex");

      selectedDayIndex = daysList
          .asMap()
          .keys
          .firstWhere((element) => daysList.asMap()[element] == int.parse(day));

      appLog("day index: $selectedDayIndex");

      yearController.animateToItem(selectedYearIndex,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
      monthController.animateToItem(selectedMonthIndex,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
      dayController.animateToItem(selectedDayIndex,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
    });
  }

  void changeCurrentCalendarTOAD(DateTime dateTime) {
    generateADDay(dateTime);
    initializeADYear();
    initializeADMonth();

    appLog("AD CANVAS FILLED");
    setState(() {
      selectedYearIndex = yearList
          .asMap()
          .keys
          .firstWhere((element) => yearList.asMap()[element] == dateTime.year);

      appLog("year index: $selectedYearIndex");
      appLog("eng month: ${dateTime.month}");
      selectedMonthIndex = monthList.asMap().keys.firstWhere((element) =>
          NepaliDateConverter.englishMonth[element] ==
          NepaliDateConverter.englishMonth[dateTime.month - 1]);

      appLog("month index: $selectedMonthIndex");

      selectedDayIndex = daysList
          .asMap()
          .keys
          .firstWhere((element) => daysList.asMap()[element] == dateTime.day);

      appLog("day index: $selectedDayIndex");

      yearController.animateToItem(selectedYearIndex,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
      monthController.animateToItem(selectedMonthIndex,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
      dayController.animateToItem(selectedDayIndex,
          duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
    });
  }

  void initializeADYear() {
    yearList.clear();
    for (int i = 1913; i <= 2050; i++) {
      yearList.add(i);
    }
  }

  void initializeBSYear() {
    yearList.clear();
    NepaliDateConverter.nepaliMap.forEach((key, value) {
      yearList.add(key);
    });
  }

  void initializeADMonth() {
    monthList.clear();
    NepaliDateConverter.englishMonth.forEach((key, value) {
      monthList.add(value);
    });
  }

  void initializeBSMonth() {
    monthList.clear();
    NepaliDateConverter.nepaliMonth.forEach((key, value) {
      monthList.add(value);
    });
  }

  void generateADDay(DateTime dateTime) {
    daysList.clear();
    DateTime dateForGettingDay = DateTime(dateTime.year, dateTime.month);
    appLog("Date for gettingDay: $dateForGettingDay");
    DateTime lastDayofMonth =
        calendar.DateUtils.getLastDayOfMonth(dateForGettingDay);
    int maxDayInMonth = lastDayofMonth.day;

    for (int i = 1; i <= maxDayInMonth; i++) {
      daysList.add(i);
    }
  }

  void generateBSDay(String dateTime) {
    var splittedDate = dateTime.split('-');
    appLog("${splittedDate[0]}");
    daysList.clear();
    var maxDaysInMonth = NepaliDateConverter
        .nepaliMap[int.parse(splittedDate[0])][int.parse(splittedDate[1])];
    for (int i = 1; i <= maxDaysInMonth; i++) {
      daysList.add(i);
    }
  }

  void setInitialDate() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedYearIndex = yearList.asMap().keys.firstWhere((element) =>
            yearList.asMap()[element] ==
            NepaliDateConverter.getYearFromDate(widget.initialDate));

        appLog("year index: $selectedYearIndex");

        selectedMonthIndex =
            NepaliDateConverter.getMonthFromDate(widget.initialDate) - 1;

        appLog("month index: $selectedMonthIndex");

        selectedDayIndex =
            NepaliDateConverter.getDayFromDate(widget.initialDate) - 1;

        yearController.animateToItem(selectedYearIndex,
            duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
        monthController.animateToItem(selectedMonthIndex,
            duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
        dayController.animateToItem(selectedDayIndex,
            duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
      });
    });
  }

  void checkDateRange() {
    DateTime selectedDateTime;
    if (calendarType == CalendarType.BS) {
      selectedDateTime = NepaliDateConverter.convertBSToAD(
          yearList[selectedYearIndex],
          selectedMonthIndex + 1,
          daysList[selectedDayIndex]);
    } else {
      selectedDateTime = DateTime.utc(yearList[selectedYearIndex],
          selectedMonthIndex + 1, daysList[selectedDayIndex]);
    }
    switch (widget.dateRange) {
      case DateRange.PAST:
        appLog("allow presentdate ${widget.allowPresentDate}");
        if (selectedDateTime.isAfter(todayAdDate
            .subtract(Duration(days: widget.allowPresentDate ? 0 : 1)))) {
          setState(() {
            hasError = true;
            errorMessage = ERROR_MSG_FUTURE_DATE_NOT_ALLOWED;
          });
        } else {
          setState(() {
            hasError = false;
          });
        }
        break;
      case DateRange.FUTURE:
        if (selectedDateTime.isBefore(todayAdDate
            .subtract(Duration(days: widget.allowPresentDate ? 0 : 1)))) {
          setState(() {
            hasError = true;
            errorMessage = ERROR_MSG_PAST_DATE_NOT_ALLOWED;
          });
        } else {
          setState(() {
            hasError = false;
          });
        }
        break;
      default:
    }
  }

  void initInitialDateIfEmpty() {
    var todayDate = DateTime.now().toUtc();
    if (widget.dateRange == DateRange.PAST) {
      if (!widget.allowPresentDate) {
        todayDate = todayDate.subtract(Duration(days: 1));
      }
    } else if (widget.dateRange == DateRange.FUTURE) {
      if (!widget.allowPresentDate) {
        todayDate = todayDate.add(Duration(days: 1));
      }
    }
    if (widget.initialDate == null || widget.initialDate.isEmpty) {
      if (widget.calendarType == CalendarType.BS) {
        widget.initialDate = NepaliDateConverter.convertADToBS(
            todayDate.year, todayDate.month, todayDate.day);
      } else {
        widget.initialDate = NepaliDateConverter.dateTimeToString(todayDate);
      }
    }
  }
}
