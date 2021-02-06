import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';
import 'calendar/index.dart';
import 'home/index.dart';
import 'me/index.dart';
import 'search/index.dart';
import 'time_line/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> bottomBarList = [
    BottomNavigationBarItem(icon: Icon(Icons.book), label: ('日记本')),
    BottomNavigationBarItem(icon: Icon(Icons.reorder), label: ('时间线')),
    BottomNavigationBarItem(icon: Icon(Icons.date_range), label: ('日历')),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ('发现')),
    BottomNavigationBarItem(icon: Icon(Icons.perm_identity), label: ('我'))
  ];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> tabBodies = [Home(), TimeLine(), Calendar(), Search(), Me()];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      body: tabBodies[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: bottomBarList,
        type: BottomNavigationBarType.fixed,
        fixedColor: GZColors.primary,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
