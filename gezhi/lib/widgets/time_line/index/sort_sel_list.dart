// 筛选排序widget
import 'package:flutter/material.dart';
import 'package:gezhi/widgets/common/common.dart';
import 'package:gezhi/style/style.dart';

class SortList extends StatefulWidget {
  const SortList({required Key key}) : super(key: key);

  @override
  _SortListState createState() => _SortListState();
}

class _SortListState extends State<SortList> {
  static final List<Map> sortList = [
    {'name': '日记本', 'sel': '全部'},
    {'name': '类型', 'sel': '全部'},
    {'name': '贴纸', 'sel': '全部'},
    {'name': '标签', 'sel': '全部'},
    {'name': '年份', 'sel': '全部'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
            ),
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
