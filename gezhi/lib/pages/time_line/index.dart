import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/common/common.dart';
import 'package:gezhi/widgets/time_line/index/list_diary_widget_item.dart';
import 'package:gezhi/widgets/time_line/index/sort_sel_list.dart';
import 'package:gezhi/widgets/time_line/index/date_line_delegate.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  bool isTit = false;
  ScrollController _controller = new ScrollController();

  int listLength = 10;

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      if (_controller.offset < 50 && isTit) {
        isTit = false;
      } else if (_controller.offset >= 50 && isTit == false) {
        isTit = true;
      }
      setState(() {});
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
            itemExtent: 100,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(), // 不能使用index做key,因为删除后index做的key会重复
                  background: Container(
                      // color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.black26,
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            color: GZColors.primary,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                      // child: Text('删除',style:TextStyle(color: Colors.white)),
                      ),
                  onDismissed: (direction) {
                    listLength--;
                    setState(() {});
                    // 返回的值是一个future
                    Navigator.pushNamed(context, '/time_line/time_line_diary');
                  },
                  child: ListDiaryWidgetItem(),
                );
              },
              childCount: listLength, //50个列表项
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
}
