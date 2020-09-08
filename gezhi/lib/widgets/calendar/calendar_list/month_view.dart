import 'package:flutter/material.dart';

import 'day_number.dart';

import 'calendar_notification.dart';


class MonthView extends StatefulWidget {
  const MonthView({
    @required this.context,
    @required this.year,
    @required this.month,
    @required this.padding,
    @required this.dateTimeStart,
    @required this.dateTimeEnd,
    @required this.onSelectDayRang,
    this.todayColor,
    this.monthNames,
  });

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final Color todayColor;
  final List<String> monthNames;
  final DateTime dateTimeStart;
  final DateTime dateTimeEnd;
  final Function onSelectDayRang;

  double get itemWidth => getDayNumberSize(context, padding);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  DateTime selectedDate;

  Widget buildMonthDays(BuildContext context) {
    List<Row> dayRows = <Row>[];
    List<DayNumber> dayRowChildren = <DayNumber>[];

    int daysInMonth = getDaysInMonth(widget.year, widget.month);

    // 日 一 二 三 四 五 六
    int firstWeekdayOfMonth = DateTime(widget.year, widget.month, 2).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      DateTime moment = DateTime(widget.year, widget.month, day);
      final bool isToday = dateIsToday(moment);

      bool isDefaultSelected = false;
      if (widget.dateTimeStart == null &&
          widget.dateTimeEnd == null &&
          selectedDate == null) {
        isDefaultSelected = false;
      }
      if (widget.dateTimeStart == selectedDate &&
          widget.dateTimeEnd == null &&
          selectedDate?.day == day &&
          day > 0) {
        isDefaultSelected = true;
      }
      if (widget.dateTimeStart != null && widget.dateTimeEnd != null) {
        isDefaultSelected = (moment.isAtSameMomentAs(widget.dateTimeStart) ||
                    moment.isAtSameMomentAs(widget.dateTimeEnd)) ||
                moment.isAfter(widget.dateTimeStart) &&
                    moment.isBefore(widget.dateTimeEnd) &&
                    day > 0
            ? true
            : false;
      }

      dayRowChildren.add(
        DayNumber(
          size: widget.itemWidth,
          day: day,
          isToday: isToday,
          isDefaultSelected: isDefaultSelected,
          todayColor: widget.todayColor,
        ),
      );

      if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(
          Row(
            children: List<DayNumber>.from(dayRowChildren),
          ),
        );
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    return NotificationListener<CalendarNotification>(
        onNotification: (notification) {
          selectedDate =
              DateTime(widget.year, widget.month, notification.selectDay);
          widget.onSelectDayRang(selectedDate);
          return true;
        },
        child: Container(
          width: 7 * getDayNumberSize(context, widget.padding),
          margin: EdgeInsets.all(widget.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MonthTitle(
                month: widget.month,
                monthNames: widget.monthNames,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: buildMonthDays(context),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildMonthView(context),
    );
  }
}


class MonthTitle extends StatelessWidget {
  const MonthTitle({
    @required this.month,
    this.monthNames,
  });

  final int month;
  final List<String> monthNames;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        getMonthName(month, monthNames: monthNames),
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }
}

bool dateIsToday(DateTime date) {
  final DateTime now = DateTime.now();
  return date.isAtSameMomentAs(DateTime(now.year, now.month, now.day));
}

int getDaysInMonth(int year, int month) {
  return month < DateTime.monthsPerYear
      ? DateTime(year, month + 1, 0).day
      : DateTime(year + 1, 1, 0).day;
}

String getMonthName(int month, {List<String> monthNames}) {
  final List<String> names = monthNames ??
      <String>[
        '一月',
        '二月',
        '三月',
        '四月',
        '五月',
        '六月',
        '七月',
        '八月',
        '九月',
        '十月',
        '十一月',
        '十二月',
      ];
  return names[month - 1];
}



enum ScreenSizes {
  small,
  medium,
  large,
}

ScreenSizes screenSize(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  if (width < 340) {
    return ScreenSizes.small;
  } else if (width < 540) {
    return ScreenSizes.medium;
  } else {
    return ScreenSizes.large;
  }
}

double getDayNumberSize(BuildContext context, double padding) {
  return (MediaQuery.of(context).size.width - padding * 2) / 7;
}

double getMonthViewHeight(BuildContext context) {
  const double padding = 8.0;
  const double titleHeight = 21.0;

  return (2 * padding) + titleHeight + 8.0 + (6 * getDayNumberSize(context, 0));
}