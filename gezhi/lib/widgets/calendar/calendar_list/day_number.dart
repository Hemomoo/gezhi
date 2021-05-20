import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';
import 'calendar_notification.dart';

class DayNumber extends StatefulWidget {
  const DayNumber({
    @required this.size,
    @required this.day,
    @required this.month,
    @required this.year,
    @required this.isDefaultSelected,
    this.isToday,
    this.todayColor = Colors.blue,
  });

  final int month;
  final int year;
  final int day;
  final bool isToday;
  final Color todayColor;
  final double size;
  final bool isDefaultSelected;

  @override
  _DayNumberState createState() => _DayNumberState();
}

class _DayNumberState extends State<DayNumber> {
  final double itemMargin = 5.0;
  bool isSelected;

  Widget _dayItem() {
    return Container(
      width: widget.size - itemMargin * 2,
      height: widget.size - itemMargin * 2,
      margin: EdgeInsets.all(itemMargin),
      alignment: Alignment.center,
      decoration: (isSelected && widget.day > 0)
          ? BoxDecoration(color: GZColors.primary, borderRadius: BorderRadiusDirectional.circular(30))
          : widget.isToday
              ? BoxDecoration(color: widget.todayColor, borderRadius: BorderRadius.circular(30))
              : null,
      child: Text(
        widget.day < 1 ? '' : widget.day.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: (widget.isToday || isSelected) ? Colors.white : Colors.black87,
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isSelected = widget.isDefaultSelected;
    return widget.day > 0
        ? InkWell(
            onTap: () {
              _dayBottomSheet();
            },
            // onTap: () => CalendarNotification(widget.day).dispatch(context),
            child: _dayItem(),
          )
        : _dayItem();
  }

  //点击展示
  void _dayBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 100,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Colors.white,
            ),
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  color: Colors.black12,
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${widget.year}-${widget.month}-${widget.day}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.book),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  '日记本',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.refresh,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  '日记本',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
