import 'package:flutter/material.dart';

import 'package:gezhi/style/style.dart';
import 'package:gezhi/utils/weekIndex.dart';

/// 本周周次 + 一周日期条
class WeekDayBar extends StatelessWidget {
  const WeekDayBar({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final week = now.weekday;
    final day = now.day;
    // 本月最后一天是几号
    final monthDay = DateTime(now.year, now.month + 1, 0).day;
    // 上个月有几天
    final prevLastDay = DateTime(now.year, now.month, 0).day;

    final dateList = _buildDateList(week, day, monthDay, prevLastDay);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2),
                ),
              ),
              child: Text(
                '${WeekIndex.weekSinceEpoch()}周',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildDayWidgets(dateList, day),
          )
        ],
      ),
    );
  }

  List<Map<String, String>> _buildDateList(
      int week, int day, int monthDay, int prevLastDay) {
    List<String> weekList = ['一', '二', '三', '四', '五', '六', '日'];
    List<Map<String, String>> dateList = [];

    for (var i = 1; i < 8; i++) {
      /*
      * 1. 如果是月初需要考虑这个星期有几天是上个月的
      * 2. 如果是月末需要考虑，后面有几个填是下个月的
      * 3. 使用了i=i 是为了和星期几相对应
      * */
      // 如果是月底，需要判断今天
      if (monthDay - day < 7) {
        if (week > i) {
          dateList.add({
            "weekday": weekList[i - 1],
            "day": (prevLastDay - (week - i) + 1).toString()
          });
        } else if (week == i) {
          dateList.add({"weekday": weekList[i - 1], "day": (day).toString()});
        } else {
          if (day + (i - week) < monthDay) {
            dateList.add({
              "weekday": weekList[i - 1],
              "day": (day + (i - week)).toString()
            });
          } else {
            dateList.add(
                {"weekday": weekList[i - 1], "day": ((i - week)).toString()});
          }
        }
      } else {
        // 如果是这个月不超过7天就从上个月开始计算
        if (day > week) {
          if (week < i) {
            dateList.add({
              "weekday": weekList[i - 1],
              "day": (day + (i - week)).toString()
            });
          } else if (week == i) {
            dateList.add({"weekday": weekList[i - 1], "day": (day).toString()});
          } else {
            dateList.add({
              "weekday": weekList[i - 1],
              "day": (day - (week - i)).toString()
            });
          }
        } else {
          if (week > i) {
            dateList.add({
              "weekday": weekList[i - 1],
              "day": (prevLastDay - (week - i) + 1).toString()
            });
          } else if (week == i) {
            dateList.add({"weekday": weekList[i - 1], "day": (day).toString()});
          } else {
            dateList.add({
              "weekday": weekList[i - 1],
              "day": (day + (i - week)).toString()
            });
          }
        }
      }
    }

    return dateList;
  }

  List<Widget> _buildDayWidgets(List<Map<String, String>> dateList, int day) {
    return dateList.map((element) {
      final isToday = day == int.parse(element["day"]!);
      return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2,
              color: Color(0xFFF0F0F0),
            ),
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              element["weekday"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isToday ? GZColors.primary : Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                element["day"]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isToday ? GZColors.primary : Colors.black,
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}
