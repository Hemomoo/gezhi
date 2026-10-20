//

import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';

class RecordGrid extends StatefulWidget {
  const RecordGrid({required Key key}) : super(key: key);

  @override
  _RecordGridState createState() => _RecordGridState();
}

class _RecordGridState extends State<RecordGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      // color: Colors.white,
      child: GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            //SliverGridDelegateWithFixedCrossAxisCount可以直接指定每行（列）显示多少个Item
            // SliverGridDelegateWithMaxCrossAxisExtent会根据GridView的宽度和你设置的每个的宽度来自动计算没行显示多少个Item
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            crossAxisCount: 20
            // maxCrossAxisExtent: 100.0,
            ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: GZColors.primary,
          );
        },
        itemCount: 365,
      ),
    );
  }
}
