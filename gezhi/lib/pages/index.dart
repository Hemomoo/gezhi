import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';
import 'calendar/index.dart';
import 'home/index.dart';
import 'me/index.dart';
import 'search/index.dart';
import 'time_line/index.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> bottomBarList = [
    BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('日记本')),
    BottomNavigationBarItem(icon: Icon(Icons.reorder), title: Text('时间线')),
    BottomNavigationBarItem(icon: Icon(Icons.date_range), title: Text('日历')),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('发现')),
    BottomNavigationBarItem(icon: Icon(Icons.perm_identity), title: Text('我'))
  ];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> tabBodies = [Home(), TimeLine(), Calendar(), Search(), Me()];

  @override
  Widget build(BuildContext context) {
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
