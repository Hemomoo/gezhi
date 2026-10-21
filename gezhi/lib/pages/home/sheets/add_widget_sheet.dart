import 'package:flutter/material.dart';

import 'package:gezhi/widgets/home/position_item.dart';

/// 添加小部件弹窗
void showAddWidgetSheet(BuildContext context) {
  List<Widget> positionItemList = [
    PositionItem(tit: '日程', index: 0, key: ValueKey(1)),
    PositionItem(tit: '名言', index: 1, key: ValueKey(2)),
    PositionItem(tit: '回忆', index: 2, key: ValueKey(3))
  ];

  List<Widget> removePositionItemList = [Text('ll')];

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
                        onReorder: (int oldIndex, int newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = positionItemList.removeAt(oldIndex);
                          positionItemList.insert(newIndex, item);
                        },
                        children: positionItemList,
                      ),
                    ),
                    Column(children: removePositionItemList)
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
