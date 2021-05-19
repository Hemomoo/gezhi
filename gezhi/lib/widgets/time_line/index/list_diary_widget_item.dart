// 首页列表的item widget
import 'package:flutter/material.dart';

class ListDiaryWidgetItem extends StatelessWidget {
  const ListDiaryWidgetItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
