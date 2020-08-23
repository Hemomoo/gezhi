import 'package:flutter/material.dart';

import 'package:gezhi/widgets/search/top.dart';

class Tags extends StatelessWidget {
  final List<Map<String, dynamic>> tagList = [
    {
      'icon': Icon(Icons.ac_unit),
      'num': 12,
    },
    {
      'icon': Icon(Icons.access_alarms),
      'num': 172,
    },
    {
      'icon': Icon(Icons.accessibility_new),
      'num': 152,
    },
    {
      'icon': Icon(Icons.ac_unit),
      'num': 12,
    },
    {
      'icon': Icon(Icons.ac_unit),
      'num': 12,
    },
    {
      'icon': Icon(Icons.access_alarms),
      'num': 172,
    },
    {
      'icon': Icon(Icons.accessibility_new),
      'num': 152,
    },
    {
      'icon': Icon(Icons.ac_unit),
      'num': 12,
    }
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
          Top(title: '贴纸', num: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Wrap(
              spacing: 10, // 主轴间的距离
              children: _tagWidgetList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _tagWidgetList() {
    return tagList.map((item) {
      return Chip(
        label: Text(item['num'].toString()),
        avatar: item['icon'],
      );
    }).toList();
  }
}
