import 'package:flutter/material.dart';
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
    BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.grey), title: Text('日记本')),
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('最美')),
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('最美'))
  ];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> tabBodies = [Home(), Me(), Calendar(), TimeLine(), Search()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBodies[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: bottomBarList,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
