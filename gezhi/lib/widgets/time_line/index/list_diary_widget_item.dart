// 首页列表的item widget
import 'package:flutter/material.dart';
import 'package:gezhi/model/time_line/diary.dart';

class ListDiaryWidgetItem extends StatelessWidget {
  final Map<String, dynamic> diary;
  final String date;
  const ListDiaryWidgetItem(this.diary, this.date, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      diary['diaryInfo'],
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
          Navigator.pushNamed(context, '/time_line/time_line_diary', arguments: {'date': date});
        },
      ),
    );
  }
}
