import 'package:flutter/material.dart';
import 'package:gezhi/utils/weekIndex.dart';


//样式
import 'package:gezhi/style/style.dart';
//小组件
import 'package:gezhi/widgets/home/diary_list.dart';
//公用组件
import 'package:gezhi/widgets/common/common.dart';
import 'package:gezhi/widgets/home/add_diary_list.dart';

import 'package:gezhi/sqlite/sql_common.dart';
// import 'package:zefyr/zefyr.dart';


class PositionItem extends StatefulWidget {
  PositionItem({required this.tit, required this.index, required Key key}) : super(key: key);  
  final String tit;
  final int index;
  @override
  _PositionItemState createState() =>
      _PositionItemState(tit: this.tit, index: this.index);
}

class _PositionItemState extends State<PositionItem> {
  final String tit;
  final int index;
  bool isDel = false;

  _PositionItemState({required this.tit, required this.index});


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 60,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      isDel = !isDel;
                    });
                  }),
              Icon(Icons.date_range),
              // Icon(Icons.date_range),
              Text(tit)
            ],
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => {print('点击了设置')}),
              Icon(Icons.menu),
              isDel
                  ? Container(
                      alignment: Alignment.center,
                      width: 40,
                      child: Text('移除'),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    DateTime today = new DateTime.now();
    String dateSlug =
        '''${today.year.toString()}年${today.month.toString().padLeft(2, '0')}月${today.day.toString().padLeft(2, '0')}''';
    String weekDay =
        ['一', '二', '三', '四', '五', '六', '日'][new DateTime.now().weekday - 1];
    final SqlUtil tipSqlite = SqlUtil.setTable('famous');

    (() async {
      var a = await tipSqlite.query();
      print(a);
    })();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              _addWidget(context);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$dateSlug $weekDay'),
            Text(
              '今天过的怎么杨？',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 4, //宽度
                    color: Colors.grey, //边框颜色
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[Text('写代码好玩吗？感觉不好好玩啊啊啊'), Text('2年前')],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    // child: FractionallySizedBox(
                    //   heightFactor: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 2),
                        ),
                      ),
                      child: Text(
                        '${WeekIndex.weekSinceEpoch()}周',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                  ),
                  // ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: dayWidgetList(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '日记本',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(8),
                  ),
                  onSelected: (value) {
                    if (value == '编辑日记本') {
                      _editDiary(context);
                    } else {
                      _addDiary(context);
                    }
                  },
                  icon: Icon(Icons.more_horiz),
                  itemBuilder: (context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: '新增日记本',
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.library_add, color: GZColors.primary),
                            SizedBox(
                              width: 10,
                            ),
                            Text('新增日记本'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: '编辑日记本',
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.create, color: GZColors.primary),
                            SizedBox(
                              width: 10,
                            ),
                            Text('编辑日记本'),
                          ],
                        ),
                      ),
                    ];
                  },
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 150,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          'assets/imgs/diary-bg.jpg',
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black12,
                        padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                        child: Text('日记本',style: TextStyle(color: Colors.white),)
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 编辑日记本
  _editDiary(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: Column(
            children: <Widget>[
              CommonWidget.line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.check_circle),
                  Text(
                    '日记本',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  PopupMenuButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.sort),
                    itemBuilder: (content) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: '新增日记本',
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.library_add, color: GZColors.primary),
                              SizedBox(width: 10),
                              Text('新增日记本'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: '管理日记本',
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.create, color: GZColors.primary),
                              SizedBox(width: 10),
                              Text('管理日记本'),
                            ],
                          ),
                        ),
                      ];
                    },
                  )
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: DiaryList(),
                ),
              ),
              // DiaryList(),
            ],
          ),
        );
      },
    );
  }

  //今天是周几
  List<Widget> dayWidgetList() {
    List<Widget> list = [];

    int week = DateTime.now().weekday; // 星期几
    int day = DateTime.now().day; // 今天是几号
    int monthDay =
        new DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
            .day; // 本月最后一天是几号
    // int monthWeekday = new DateTime(DateTime.now().year, DateTime.now().month+1, monthDay).weekday; // 本月最后一天星期几
    print(monthDay);
    // 判断上一个月有多少天啊
    int prevLastDay = new DateTime(DateTime.now().year, DateTime.now().month, 0)
        .day; // 上个月有几天

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

    // dateList.insert(0, dateList.removeLast());

    dateList.forEach(
      (element) {
        list.add(Container(
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
                    color: day == int.parse(element["day"]!)
                        ? GZColors.primary
                        : Colors.black),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  element["day"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: day == int.parse(element["day"]!)
                          ? GZColors.primary
                          : Colors.black),
                ),
              )
            ],
          ),
        ));
      },
    );
    return list;
  }

  // 添加小部件
  void _addWidget(BuildContext context) {
    List<Widget> _positionItemList = [
      PositionItem(tit: '日程', index: 0, key: ValueKey(1)),
      PositionItem(tit: '名言', index: 1, key: ValueKey(2)),
      PositionItem(tit: '回忆', index: 2, key: ValueKey(3))
    ];

    List<Widget> _removePositionItemList = [Text('ll')];

    TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(14),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, state) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              // width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.black12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '取消',
                              style: textStyle,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Center(
                          child: Text(
                            '添加小部件',
                            style: textStyle,
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '完成',
                              style: textStyle,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: ReorderableListView(
                          // shrinkWrap:true,
                          onReorder: (int oldIndex, int newIndex) {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final item = _positionItemList.removeAt(oldIndex);
                            _positionItemList.insert(newIndex, item);
                          },
                          children: _positionItemList,
                        ),
                      ),
                      Column(children: _removePositionItemList)
                    ],
                  )),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //新增日记本
  void _addDiary(BuildContext context) {
    int selIndex = -1;
    int step = 1;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(14),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, addDiaryState) {
            return Container(
              padding: EdgeInsets.all(10),
              color: Colors.black12,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        '自定义',
                        style: TextStyle(fontSize: 20.0),
                      )
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            step == 1 || step == 2
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('$step/2'),
                                      Text('你想要通过日记实现'),
                                      Text(
                                        '什么目的',
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  )
                                : Container(),
                            step == 1
                                ? AddDiaryList(UniqueKey(), (index) {
                                    addDiaryState(() {
                                      selIndex = index;
                                    });
                                  }, step, selIndex)
                                : step == 2
                                    ? AddDiaryList(UniqueKey(), (index) {
                                        addDiaryState(() {
                                          selIndex = index;
                                        });
                                      }, step, selIndex)
                                    : Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            AnimatedContainer(
                                              height: 200,
                                              width: 150,
                                              alignment: Alignment.center,
                                              duration: Duration(seconds: 3),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        'https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                    10,
                                                  ))),
                                            )
                                          ],
                                        ),
                                      ),
                            step != 1 && step != 2
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('你完成'),
                                      Text(
                                        '你的日记本已经准备',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '就绪',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 10,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  addDiaryState(() {
                                    step++;
                                    selIndex = -1;
                                    if (step == 4) Navigator.of(context).pop();
                                  });
                                },
                                child: _stepWidget(selIndex, step),
                              ),
                              step != 1 && step != 2
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: GestureDetector(
                                          child: Text('日记设置',
                                              style: TextStyle(
                                                  color: GZColors.primary))),
                                    )
                                  : Text(''),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  //按钮widget封装
  Widget _stepWidget(selIndex, step) {
    return Container(
      key: UniqueKey(),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selIndex == -1 && step != 3 ? Colors.black12 : Colors.black87,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(step == 1 || step == 2 ? '继续' : '保存',
          style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
