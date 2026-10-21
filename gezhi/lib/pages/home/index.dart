import 'package:flutter/material.dart';

import 'package:gezhi/pages/home/sheets/add_diary_sheet.dart';
import 'package:gezhi/pages/home/sheets/add_widget_sheet.dart';
import 'package:gezhi/pages/home/sheets/edit_diary_sheet.dart';
import 'package:gezhi/pages/home/widgets/diary_book_card.dart';
import 'package:gezhi/pages/home/widgets/week_day_bar.dart';
import 'package:gezhi/sqlite/diary_dao.dart';
import 'package:gezhi/style/style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic>? _todayDiary;
  bool _loadingDiary = true;

  @override
  void initState() {
    super.initState();
    _loadTodayDiary();
  }

  Future<void> _loadTodayDiary() async {
    final row = await DiaryDao.findByDate(_formatDate(DateTime.now()));
    if (!mounted) return;
    setState(() {
      _todayDiary = row;
      _loadingDiary = false;
    });
  }

  Future<void> _openDiaryEditor() async {
    final now = DateTime.now();
    final changed = await Navigator.pushNamed(
      context,
      '/time_line/revised_diary',
      arguments: {
        'id': _todayDiary?['id'],
        'date': _formatDate(now),
        'tit': _formatDateCn(now),
      },
    );
    if (changed == true) {
      _loadTodayDiary();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateCn(DateTime date) {
    return '${date.year}年${date.month.toString().padLeft(2, '0')}月${date.day.toString().padLeft(2, '0')}日';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateSlug =
        '''${now.year.toString()}年${now.month.toString().padLeft(2, '0')}月${now.day.toString().padLeft(2, '0')}''';
    final weekDay = ['一', '二', '三', '四', '五', '六', '日'][now.weekday - 1];

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
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _openDiaryEditor,
              child: Container(
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
                    children: <Widget>[
                      Text(
                        _loadingDiary
                            ? '加载中...'
                            : (_todayDiary?['diaryInfo'] as String? ??
                                '还没有日记，点击记录今天'),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      Text(
                        _todayDiary == null ? '今天' : '今天 · 点击编辑',
                        style: TextStyle(color: Colors.black38),
                      )
                    ],
                  ),
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
