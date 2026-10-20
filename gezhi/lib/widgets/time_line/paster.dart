// 贴纸
import 'package:flutter/material.dart';

class Paster extends StatefulWidget {
  const Paster({required Key key}) : super(key: key);

  @override
  _PasterState createState() => _PasterState();
}

class _PasterState extends State<Paster> {
  int _itemCount = 20;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, //横轴三个子widget
        childAspectRatio: 1.0,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if (index == 19) {
              setState(() {
                _itemCount = 50;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: index != 19 ? Icon(Icons.settings) : Icon(Icons.more_horiz),
          ),
        );
      },
    );
  }
}
