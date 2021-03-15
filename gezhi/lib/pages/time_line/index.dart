import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/common/common.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  static List<Map> sortList = [
    {'name': '日记本', 'sel': '全部'},
    {'name': '类型', 'sel': '全部'},
    {'name': '贴纸', 'sel': '全部'},
    {'name': '标签', 'sel': '全部'},
    {'name': '年份', 'sel': '全部'},
  ];

  bool isTit = false;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      if (_controller.offset < 50 && isTit) {
        setState(() {
          isTit = false;
        });
      } else if (_controller.offset >= 50 && isTit == false) {
        setState(() {
          isTit = true;
        });
      }
    });
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
            ' ${isTit ? '时间线' : ''}',
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
              _editDiary1(context);
            },
          ),
        ],
      ),
      body: CustomScrollView(controller: _controller, slivers: <Widget>[
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
          delegate: MyDelegate(),
          pinned: true,
        ),
        SliverFixedExtentList(
          itemExtent: 100,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Text(
                              '28',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('8月')
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                '大张伟，娱乐圈的救护车，综艺节目共享嘉宾，擅长各种救场',
                                maxLines: 2,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Text(
                              '日记本',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.black26),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/time_line/time_line_diary');
                  },
                ),
              );
            },
            childCount: 50, //50个列表项
          ),
        ),
      ]),
    );
  }

  void _editDiary1(BuildContext context) {
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
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(14))),
            child: Stack(
              children: [
                Column(
                  children: [
                    CommonWidget.line(),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    _title(),
                    Expanded(child: _sortWidget()),
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
                      onTap: () => {print('121')},
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

  Widget _sortWidget() {
    return Container(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sortList[index]['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    sortList[index]['sel'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: GZColors.primary),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(), // 取消约束
                    icon: Icon(Icons.keyboard_arrow_right),
                    onPressed: () {
                      print('121');
                    },
                  )
                ],
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return CommonWidget.divider;
        },
        itemCount: sortList.length,
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 48,
      padding: EdgeInsets.only(left: 15, right: 15),
      color: Colors.white,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '2020',
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 30;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
