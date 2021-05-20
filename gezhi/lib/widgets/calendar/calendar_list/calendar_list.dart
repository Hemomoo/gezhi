library calendar_list;

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'month_view.dart';

class CalendarList extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedStartDate;
  final DateTime selectedEndDate;
  final Function onSelectFinish;
  final EventBus eventBus;
  final double initialScrollOffset; // 默认滚动距离

  CalendarList(
      {@required this.firstDate,
      @required this.lastDate,
      @required this.initialScrollOffset,
      this.onSelectFinish,
      this.selectedStartDate,
      this.selectedEndDate,
      this.eventBus})
      : assert(firstDate != null),
        assert(lastDate != null),
        assert(!firstDate.isAfter(lastDate), 'lastDate must be on or after firstDate');

  @override
  _CalendarListState createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  final double HORIZONTAL_PADDING = 25.0;
  DateTime selectStartTime;
  DateTime selectEndTime;
  int yearStart;
  int monthStart;
  int yearEnd;
  int monthEnd;
  int count;
  int initCount;
  double initialScrollOffset;
  double oldOffset;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    // 传入的开始日期
    selectStartTime = widget.selectedStartDate;
    // 传入的结束日期
    selectEndTime = widget.selectedEndDate;
    yearStart = widget.firstDate.year;
    monthStart = widget.firstDate.month;
    yearEnd = widget.lastDate.year;
    monthEnd = widget.lastDate.month;
    count = monthEnd - monthStart + (yearEnd - yearStart) * 12 + 1;
    initCount = DateTime.now().month - monthStart + (DateTime.now().year - yearStart) * 12 + 1;

    // 延时1s执行返回
    Future.delayed(Duration(seconds: 0), () {
      // print('延时1s执行');
    });

    _controller = ScrollController(initialScrollOffset: widget.initialScrollOffset);

    _controller.addListener(() {
      // if (_controller.offset == 100) {
      //   Future.delayed(Duration(microseconds: 1)).then((value) {
      //     monthStart = monthStart - 1;
      //     setState(() {});
      //   });
      // }

      // print(_controller.offset); //打印滚动位置
    });
  }

  // 选项处理回调
  void onSelectDayChanged(dateTime) {
    if (selectStartTime == null && selectEndTime == null) {
      selectStartTime = dateTime;
    } else if (selectStartTime != null && selectEndTime == null) {
      selectEndTime = dateTime;
      // 如果选择的开始日期和结束日期相等，则清除选项
      if (selectStartTime == selectEndTime) {
        setState(() {
          selectStartTime = null;
          selectEndTime = null;
        });
        return;
      }
      // 如果用户反选，则交换开始和结束日期
      if (selectStartTime?.isAfter(selectEndTime)) {
        DateTime temp = selectStartTime;
        selectStartTime = selectEndTime;
        selectEndTime = temp;
      }
    } else if (selectStartTime != null && selectEndTime != null) {
      selectStartTime = null;
      selectEndTime = null;
      selectStartTime = dateTime;
    }
    setState(() {
      selectStartTime;
      selectEndTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        controller: _controller,
        cacheExtent: 10,
        semanticChildCount: 100,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                int month = index + monthStart;
                DateTime calendarDateTime = DateTime(yearStart, month);
                return _getMonthView(calendarDateTime, widget.eventBus);
              },
              childCount: count,
            ),
          ),
        ],
      ),
    );
  }

  void _finishSelect() {
    if (selectStartTime != null) {
      widget.onSelectFinish(selectStartTime, selectEndTime);
    }
  }

  Widget _getMonthView(DateTime dateTime, EventBus eventBus) {
    int year = dateTime.year;
    int month = dateTime.month;
    return MonthView(
      context: context,
      year: year,
      month: month,
      padding: 0,
      dateTimeStart: selectStartTime,
      dateTimeEnd: selectEndTime,
      todayColor: Color(0XFF00acc1),
      eventBus: eventBus,
      onSelectDayRang: (dateTime) => onSelectDayChanged(dateTime),
    );
  }
}
