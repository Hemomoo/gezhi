import 'package:flutter/material.dart';
import 'package:gezhi/widgets/common/common.dart';

class Top extends StatelessWidget {
  final String title;
  final int num;
  final String url;
  Top({required this.title, required this.num, this.url = ''});



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
              children: [Chip(label: Text(num.toString())), CommonWidget.arrow()],
            ),
          ],
        ),
      ),
      onTap: () => {
        if (url == '') {} else {print('121'), Navigator.pushNamed(context, url)},
      },
    );
  }
}
