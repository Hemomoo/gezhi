import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//样式
import 'package:gezhi/style/style.dart';

//小组件
import 'package:gezhi/widgets/home/diary_list.dart';
//公用组件
import 'package:gezhi/widgets/common/common.dart';

import 'package:draggable_flutter_list/draggable_flutter_list.dart';

import 'package:gezhi/widgets/home/small_widget.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime today = new DateTime.now();
    String dateSlug =
        '''${today.year.toString()}年${today.month.toString().padLeft(2, '0')}月${today.day.toString().padLeft(2, '0')}''';

    String weekDay =
        ['一', '二', '三', '四', '五', '六', '日'][new DateTime.now().weekday - 1];

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
                        '30周',
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
                      _editeDiary(context);
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
            )
          ],
        ),
      ),
    );
  }

  // 编辑日记本
  _editeDiary(BuildContext context) {
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
                  IconButton(icon: Icon(Icons.edit), onPressed: null),
                  Text(
                    '日记本',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  PopupMenuButton(
                    icon: Icon(Icons.sort),
                    itemBuilder: (content) {
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

  List<Widget> dayWidgetList() {
    List<Widget> list = new List();
    int week = DateTime.now().weekday;
    int day = DateTime.now().day - week;
    List<String> weekList = ['日', '一', '二', '三', '四', '五', '六'];
    List<Map<String, String>> dateList = [];

    for (var i = 0; i < 7; i++) {
      dateList.add({"weekday": weekList[i], "day": (day + i).toString()});
    }

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
                element["weekday"],
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  element["day"],
                  textAlign: TextAlign.center,
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
  _addWidget(BuildContext context) {
    TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    List<String> items = ['0', '1', 'd'];
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
                    child: DragAndDropList(
                      items.length,
                      itemBuilder: (BuildContext context, index) {
                        return SizedBox(
                          child: Card(
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(0),
                            ),
                            child:TestAnimation(),
                          ),
                        );
                      },
                      onDragFinish: (before, after) {
                        String data = items[before];
                        items.removeAt(before);
                        items.insert(after, data);
                      },
                      canDrag: (index) {
                        return index < 5; //disable drag for index 3
                      },
                      canBeDraggedTo: (from, to) {
                        return to < 5;
                      },
                      dragElevation: 8.0,
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
}
