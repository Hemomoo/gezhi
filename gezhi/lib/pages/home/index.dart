import 'package:flutter/material.dart';

//样式
import 'package:gezhi/style/style.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('2020年7月19日 星期日'),
            Text(
              '今天过的怎么杨？',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(width: 2))),
                      child: Text(
                        '30周',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: dayWidgetList(),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '日记本',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    _editeDiary(context);
                    print('$value');
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
                // SizedBox(
                //   height: 10,
                //   width: double.infinity,
                // ),
                Center(
                  child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.edit), onPressed: null),
                    Text('日记本',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    PopupMenuButton(
                      icon: Icon(Icons.sort),
                      itemBuilder: (content) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: '新增日记本',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.library_add,
                                    color: GZColors.primary),
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
          );
        });
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

    dateList.forEach((element) {
      print(element["day"]);
      list.add(Container(
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(width: 2, color: Color(0xFFF0F0F0)))),
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
    });
    return list;
  }
}
