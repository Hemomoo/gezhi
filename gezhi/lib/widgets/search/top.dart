import 'package:flutter/material.dart';
import 'package:gezhi/widgets/common/common.dart';

class Top extends StatelessWidget {
  final String title;
  final int num;
  Top({@required this.title, @required this.num});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [Text(num.toString()), CommonWidget.arrow()],
            ),
          ],
        ),
      ),
      onTap: () => {print('12121')},
    );
  }
}
