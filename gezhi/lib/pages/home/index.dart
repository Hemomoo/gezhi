import 'package:flutter/material.dart';

import 'package:gezhi/pages/home/sheets/add_diary_sheet.dart';
import 'package:gezhi/pages/home/sheets/add_widget_sheet.dart';
import 'package:gezhi/pages/home/sheets/edit_diary_sheet.dart';
import 'package:gezhi/pages/home/widgets/diary_book_card.dart';
import 'package:gezhi/pages/home/widgets/week_day_bar.dart';
import 'package:gezhi/sqlite/sql_common.dart';
import 'package:gezhi/style/style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateSlug =
        '''${now.year.toString()}年${now.month.toString().padLeft(2, '0')}月${now.day.toString().padLeft(2, '0')}''';
    final weekDay = ['一', '二', '三', '四', '五', '六', '日'][now.weekday - 1];
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
              showAddWidgetSheet(context);
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
            WeekDayBar(),
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
                      showEditDiarySheet(context);
                    } else {
                      showAddDiarySheet(context);
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
            DiaryBookCard(),
          ],
        ),
      ),
    );
  }
}
