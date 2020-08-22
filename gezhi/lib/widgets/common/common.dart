import 'package:flutter/material.dart';

class CommonWidget {
  static const Widget divider = Divider(
    color: Colors.black12,
  );

  // 线
  static Widget line() {
    return Center(
      child: Container(
          width: 50,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          )),
    );
  }

  static Widget arrow() {
    return Icon(
      Icons.keyboard_arrow_right,
      size: 30,
    );
  }
}
