import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Statistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0, //设置阴影
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          // 渐变色
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              GZColors.primary,
              Color(0XFF75eccd),
            ],
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '统计',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              height: ScreenUtil().setHeight(240.0).toDouble(),
              padding: EdgeInsets.all(14),
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 2,
                children: <Widget>[
                  _gridWidget('798', '日记'),
                  _gridWidget('901', '格志'),
                  _gridWidget('41,695', '字符'),
                  _gridWidget('2019/9/4', '开始日期'),
                  _gridWidget('0', '当前连续'),
                  _gridWidget('78', '最长连续'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridWidget(String data, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
