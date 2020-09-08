import 'package:flutter/material.dart';
import 'utils/screen_sizes.dart';

class WeekdayRow extends StatelessWidget {

  Widget _weekdayContainer(BuildContext context,String weekDay) => Expanded(
        child: Container(
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
              child: Text(
                weekDay,
              ),
            ),
          ),
        ),
      );

  List<Widget> _renderWeekDays(BuildContext context) {
    List<Widget> list = [];
    list.add(_weekdayContainer(context,"日"));
    list.add(_weekdayContainer(context,"一"));
    list.add(_weekdayContainer(context,"二"));
    list.add(_weekdayContainer(context,"三"));
    list.add(_weekdayContainer(context,"四"));
    list.add(_weekdayContainer(context,"五"));
    list.add(_weekdayContainer(context,"六"));
    return list;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 7 * getDayNumberSize(context, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _renderWeekDays(context),
      ),
    );
  }
}
