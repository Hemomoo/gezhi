// weekList 首页日期行
import 'package:flutter/material.dart';
import 'package:gezhi/sqlite/sql_common.dart';
//样式
import 'package:gezhi/style/style.dart';
import 'package:gezhi/utils/num_padding.dart';

class WeekList extends StatefulWidget {
  const WeekList({required Key key}) : super(key: key);

  @override
  _WeekListState createState() => _WeekListState();
}

class _WeekListState extends State<WeekList> {
  List<Widget> list = [];
  final int week = DateTime.now().weekday; // 星期几
  final int day = DateTime.now().day; // 今天是几号
  final int monthDay = new DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day; // 本月最后一天是几号
  // int monthWeekday = new DateTime(DateTime.now().year, DateTime.now().month+1, monthDay).weekday; // 本月最后一天星期几
  // 判断上一个月有多少天啊
  final int prevLastDay = new DateTime(DateTime.now().year, DateTime.now().month, 0).day; // 上个月有几天
  List<dynamic> writeDay = [];
  List<String> weekList = ['一', '二', '三', '四', '五', '六', '日'];
  List<Map<String, String>> dateList = [];
  Object writeMonth = DateTime.now().month < 10 ? '0${DateTime.now().month.toString()}' : DateTime.now().month;
  String year = new DateTime.now().year.toString();
  @override
  void initState() {
    // TODO: implement initState
    /*
        * 1. 如果是月初需要考虑这个星期有几天是上个月的
        * 2. 如果是月末需要考虑，后面有几个填是下个月的
        * 3. 使用了i=i 是为了和星期几相对应
        *
        * */
    for (var i = 1; i < 8; i++) {
      // 如果是月底，需要判断今天
      if (monthDay - day < 7) {
        if (week > i) {
          dateList.add({"weekday": weekList[i - 1], "day": (day - (week - i)).toString()});
        } else if (week == i) {
          dateList.add({"weekday": weekList[i - 1], "day": (day).toString()});
        } else {
          if (day + (i - week) < monthDay) {
            dateList.add({"weekday": weekList[i - 1], "day": (day + (i - week)).toString()});
          } else {
            dateList.add({"weekday": weekList[i - 1], "day": ((i - week)).toString()});
          }
        }
      } else {
        // 如果是这个月不超过7天就从上个月开始计算
        if (day > week) {
          if (week < i) {
            dateList.add({"weekday": weekList[i - 1], "day": (day + (i - week) + 1).toString()});
          } else if (week == i) {
            dateList.add({"weekday": weekList[i - 1], "day": (day).toString()});
          } else {
            dateList.add({"weekday": weekList[i - 1], "day": (day - (week - i)).toString()});
          }
        } else {
          if (week > i) {
            if (day - (week - i) <= 0) {
              dateList.add({"weekday": weekList[i - 1], "day": (prevLastDay - i + 1).toString()});
            } else {
              dateList.add({"weekday": weekList[i - 1], "day": (day - (week - i)).toString()});
            }
          } else if (week == i) {
            dateList.add({"weekday": weekList[i - 1], "day": (day).toString()});
          } else {
            dateList.add({"weekday": weekList[i - 1], "day": (day + (i - week)).toString()});
          }
        }
      }
    }

    // dateList.insert(0, dateList.removeLast());

    List<String> dayList = dateList.map((e) {
      String val = year + '-' + writeMonth.toString() + '-' + numPadding(e['day']);
      return '"' + val + '"';
    }).toList();

    final SqlUtil sqlite = SqlUtil.setTable('diary');
    String sqlString = dayList.join(",");
    print(sqlString);
    sqlite.rawQuery('SELECT date FROM diary WHERE date IN (' + sqlString + ')', null).then((value) {
      print(value);
      value.forEach((element) {
        writeDay.add(element['date'].split('-').last);
      });
      print(writeDay);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: _dayWidgetList(),
    );
  }

  //今天是周几
  List<Widget> _dayWidgetList() {
    return dateList.map((element) {
      print(element['day']);
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
            GestureDetector(
              child: writeDay.indexOf(element['day']) != -1
                  ? Text(
                      element["weekday"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: day == int.parse(element["day"]!) ? GZColors.primary : Colors.black),
                    )
                  : Text(
                      element["weekday"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: day == int.parse(element["day"]!) ? GZColors.primary : Colors.black),
                    ),
              onTap: () {
                _dayBottomSheet('$year-$writeMonth-${element['day']}');
              },
            ),
            GestureDetector(
              onTap: () {
                _dayBottomSheet('$year-$writeMonth-${element['day']}');
              },
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: writeDay.indexOf(numPadding(element['day'])) != -1 ? GZColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                ),
                // padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: writeDay.indexOf(element['day']) != -1
                    ? Text(
                        element["day"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(
                        element["day"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: day == int.parse(element["day"]!) ? GZColors.primary : Colors.black),
                      ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  //点击展示
  void _dayBottomSheet(String date) {
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
                    date,
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
                        onTap: () {
                          Navigator.pop(context); // 先关闭弹窗 在跳转
                          Navigator.pushNamed(context, '/time_line/time_line_diary', arguments: {'date': date});
                        },
                        child: Container(
                          color: Colors.transparent,
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
      },
    );
  }
}
