import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezhi/utils/weekIndex.dart';

//样式
import 'package:gezhi/style/style.dart';

//公用组件
import 'package:gezhi/widgets/common/common.dart';

import 'package:draggable_flutter_list/draggable_flutter_list.dart';
import 'package:gezhi/widgets/home/small_widget.dart';
import 'package:gezhi/sqlite/sql_common.dart';
import 'package:gezhi/widgets/home/week_list.dart';
// import 'package:zefyr/zefyr.dart';

import 'package:gezhi/widgets/home/add_diary.dart';
import 'package:gezhi/widgets/home/edit_diary.dart';

class PositionItem extends StatefulWidget {
  PositionItem({this.tit, this.index, Key key}) : super(key: key);
  final String tit;
  final int index;
  @override
  _PositionItemState createState() => _PositionItemState(tit: this.tit, index: this.index);
}

class _PositionItemState extends State<PositionItem> {
  final String tit;
  final int index;
  bool isDel = false;

  _PositionItemState({this.tit, this.index});

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
              IconButton(icon: Icon(Icons.settings), onPressed: () => {print('点击了设置')}),
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
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    DateTime today = new DateTime.now();
    String dateSlug = '''${today.year.toString()}年${today.month.toString().padLeft(2, '0')}月${today.day.toString().padLeft(2, '0')}''';
    String weekDay = ['一', '二', '三', '四', '五', '六', '日'][new DateTime.now().weekday - 1];
    final SqlUtil tipSqlite = SqlUtil.setTable('famous');
    (() async {
      var a = await tipSqlite.query();
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                  ),
                  // ),
                  WeekList()
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
                      editDiary(context);
                    } else {
                      addDiary(context);
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
                      padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                      child: Text(
                        '日记本',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 添加小部件
  void _addWidget(BuildContext context) {
    List<Widget> _positionItemList = [
      PositionItem(tit: '日程', key: ValueKey(1)),
      PositionItem(tit: '名言', key: ValueKey(2)),
      PositionItem(tit: '回忆', key: ValueKey(3))
    ];

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
}
