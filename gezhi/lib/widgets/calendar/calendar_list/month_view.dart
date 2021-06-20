import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'calendar_notification.dart';
import 'weekday_row.dart';
import 'day_number.dart';
import 'month_title.dart';
import 'utils/dates.dart';
import 'utils/screen_sizes.dart';
import 'week_number.dart';
import 'package:gezhi/widgets/calendar/calendar_list/utils/chang_year.dart';

class MonthView extends StatefulWidget {
  const MonthView({
    @required this.context,
    @required this.year,
    @required this.month,
    @required this.padding,
    @required this.dateTimeStart,
    @required this.dateTimeEnd,
    @required this.onSelectDayRang,
    this.eventBus,
    this.todayColor,
    this.monthNames,
  });

  final EventBus eventBus;
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

  Widget buildWeek(BuildContext context) {
    List<int> weekList = getWeekNum(widget.year, widget.month);
    List<Widget> _weekWidgetList() {
      return weekList.map((e) {
        return WeekNumber(
          day: e.toString(),
          size: widget.itemWidth,
        );
      }).toList();
    }
    return Column(
      children: _weekWidgetList(),
    );
  }

  Widget buildMonthDays(BuildContext context) {
    List<Row> dayRows = <Row>[];
    List<DayNumber> dayRowChildren = <DayNumber>[];

    int daysInMonth = getDaysInMonth(widget.year, widget.month);
    widget.eventBus.fire(Year(widget.year.toString()));

    // 日 一 二 三 四 五 六
    int firstWeekdayOfMonth = DateTime(widget.year, widget.month, 2).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      DateTime moment = DateTime(widget.year, widget.month, day);
      // 是不默认选择
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
        selectedDate = DateTime(
          widget.year,
          widget.month,
          notification.selectDay,
        );
        widget.onSelectDayRang(selectedDate);
        return true;
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MonthTitle(
                    month: 1,
                    color: Colors.transparent,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Center(
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                        child: Text(
                          'CW',
                          style: TextStyle(color: Colors.black12),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: buildWeek(context),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MonthTitle(
                    month: widget.month,
                    monthNames: widget.monthNames,
                  ),
                  WeekdayRow(),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: buildMonthDays(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildMonthView(context),
    );
  }
}
