import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/common/common.dart';
import 'package:gezhi/widgets/time_line/index/list_diary_widget_item.dart';
import 'package:gezhi/widgets/time_line/index/sort_sel_list.dart';
import 'package:gezhi/widgets/time_line/index/date_line_delegate.dart';
import 'package:gezhi/sqlite/sql_common.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

import 'package:gezhi/model/time_line/diary.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  bool isTit = false;
  ScrollController _controller = new ScrollController();
  final SqlUtil diarySql = SqlUtil.setTable('diary');
  List<Map<String, dynamic>> _diaryList = [];
  int listLength = 10;
  int selId;

  @override
  void initState() {
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      if (_controller.offset < 50 && isTit) {
        isTit = false;
      } else if (_controller.offset >= 50 && isTit == false) {
        isTit = true;
      }
      setState(() {});
    });

    (() async {
      //获取所有数据
      // _diaryList = await diarySql.rawQuery('delete from diary where diary.rowid not in (select MAX(diary.rowid) from diary group by date)', null);
      _diaryList = await diarySql.rawQuery('SELECT * from diary group by date', null);
      setState(() {});
    })();

    super.initState();
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '${isTit ? '时间线' : ''}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          new IconButton(
            // action button
            icon: new Icon(Icons.filter_list),
            onPressed: () {
              _editDiary(context);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          SliverAppBar(
            // expandedHeight: 80,
            elevation: 0,
            leading: Container(
              color: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                '时间线',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: DateLineDelegate(),
            pinned: true,
          ),
          SliverFixedExtentList(
            key: UniqueKey(),
            itemExtent: 100,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Slidable(
                  actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
                  actionExtentRatio: 0.16,
                  child: ListDiaryWidgetItem(_diaryList[index], _diaryList[index]['date'], key: UniqueKey()),
                  secondaryActions: <Widget>[
                    //右侧按钮列表
                    IconSlideAction(
                      // caption: 'More',
                      color: Colors.black26,
                      icon: Icons.more_horiz,
                      closeOnTap: false,
                      onTap: () {
                        selId = _diaryList[index]['id'];
                        _editDiaryInfo(context);
                      },
                    ),
                    IconSlideAction(
                      // caption: 'Delete',
                      color: GZColors.primary,
                      icon: Icons.edit,
                      closeOnTap: false,
                      onTap: () {
                        Navigator.pushNamed(context, '/time_line/time_line_diary', arguments: {'date': _diaryList[index]['date']}).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  ],
                );
              },
              childCount: _diaryList.length,
            ),
          ),
        ],
      ),
    );
  }

  void _editDiary(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // 全屏幕展示
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Stack(
              children: [
                Column(
                  children: [
                    CommonWidget.line(),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    _title(),
                    Expanded(child: SortList()),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: InkWell(
                      child: Text(
                        '完成',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _editDiaryInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // 全屏幕展示
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('在日记本中显示'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(Icons.tag_faces),
                    title: Text('编辑贴纸'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: Transform.rotate(
                      angle: 10.0,
                      child: Icon(Icons.label),
                    ),
                    title: Text('编辑标签'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: Transform.rotate(
                      angle: 0.0,
                      child: Icon(Icons.upgrade),
                    ),
                    title: Text('导出'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(Icons.copy),
                    title: Text('拷贝'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(Icons.add_to_photos),
                    title: Text('拷贝到...'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(Icons.move_to_inbox),
                    title: Text('拷贝到...'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop(true);
                    bool delete = await showDeleteConfirmDialog();
                    if (delete == null) {
                      print("取消删除");
                    } else {
                      // print("已确认删除");
                      diarySql.delete('id', selId).then((value) {
                        diarySql.rawQuery('SELECT * from diary group by date', null).then((value) {
                          _diaryList = value;
                          setState(() {});
                        });
                      });
                    }
                  },
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('删除'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '重置',
          style: TextStyle(color: Colors.transparent),
        ),
        Center(
          child: Text(
            '过滤',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '重置',
          style: TextStyle(color: Colors.black12),
        )
      ],
    );
  }

// 弹出对话框
  Future<bool> showDeleteConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("您真的要删除吗？")),
          content: Text("此操作无法撤销"),
          actions: <Widget>[
            TextButton(
              child: Text(
                "取消",
                style: TextStyle(color: GZColors.primary),
              ),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            TextButton(
              child: Text(
                "删除",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
