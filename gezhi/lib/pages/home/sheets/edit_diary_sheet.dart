import 'package:flutter/material.dart';

import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/common/common.dart';
import 'package:gezhi/widgets/home/diary_list.dart';

/// 编辑日记本弹窗
void showEditDiarySheet(BuildContext context) {
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
                    ];
                  },
                )
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: DiaryList(),
              ),
            ),
          ],
        ),
      );
    },
  );
}
