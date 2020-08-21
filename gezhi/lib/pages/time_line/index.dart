import 'package:flutter/material.dart';
import 'package:gezhi/widgets/common/common.dart';

class TimeLine extends StatelessWidget {
  static List<Map> sortList = [
    {'name': '日记本', 'sel': '全部'},
    {'name': '类型', 'sel': '全部'},
    {'name': '贴纸', 'sel': '全部'},
    {'name': '标签', 'sel': '全部'},
    {'name': '年份', 'sel': '全部'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: new Text(
            '时间线',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
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
              _editeDiary1(context);
            },
          ),
        ],
      ),
    );
  }

  _editeDiary1(BuildContext context) {
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
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(14))),
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
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      child: Text(
                        '完成',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    sortList[index]['sel'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
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
