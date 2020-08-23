import 'package:flutter/material.dart';

import 'package:gezhi/widgets/search/top.dart';

class Year extends StatelessWidget {
  final List<Map<String, dynamic>> yearList = [
    {'year': '2012', 'num': 100},
    {'year': '2020', 'num': 20},
    {'year': '2012', 'num': 10},
    {'year': '2012', 'num': 14},
    {'year': '2019', 'num': 16},
    {'year': '2022', 'num': 177},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
      ),
      child: Column(
        children: [
          Top(title: '年份', num: 10),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              children: _yearWidgetList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _yearWidgetList() {
    return yearList
        .map(
          (item) => Chip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item['year'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  item['num'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black26,
                  ),
                )
              ],
            ),
          ),
        )
        .toList();
  }
}
