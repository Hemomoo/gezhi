import 'package:flutter/material.dart';


class WeekNumber extends StatefulWidget {
  const WeekNumber({
    required this.size,
    required this.day,
    this.isToday = false,
    this.todayColor = Colors.blue,
  });

  final String day;
  final bool isToday;
  final Color todayColor;
  final double size;

  @override
  _WeekNumberState createState() => _WeekNumberState();
}

class _WeekNumberState extends State<WeekNumber> {
  final double itemMargin = 5.0;


  Widget _weekItem() {
    return Container(
      width: widget.size - itemMargin * 2,
      height: widget.size - itemMargin * 2,
      margin: EdgeInsets.all(itemMargin),
      alignment: Alignment.center,

      child: Text(
        widget.day,
        textAlign: TextAlign.center,
        style: TextStyle(
          color:Colors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  _weekItem();
  }
}
