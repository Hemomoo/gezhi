// 编辑日记本
import 'package:flutter/material.dart';
import 'package:gezhi/widgets/common/common.dart';
//样式
import 'package:gezhi/style/style.dart';
//小组件
import 'package:gezhi/widgets/home/diary_list.dart';

void editDiary(BuildContext context) {
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
            CommonWidget.line(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.check_circle),
                Text(
                  '日记本',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                PopupMenuButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.sort),
                  itemBuilder: (content) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: '新增日记本',
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.library_add, color: GZColors.primary),
                            SizedBox(width: 10),
                            Text('新增日记本'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: '管理日记本',
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.create, color: GZColors.primary),
                            SizedBox(width: 10),
                            Text('管理日记本'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: '锁住',
                        child: Row(
                          children: [
                            Icon(Icons.lock),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('锁住'),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            Expanded(
              child: Container(width: double.infinity, child: DiaryList()),
            ),
            // DiaryList(),
          ],
        ),
      );
    },
  );
}
