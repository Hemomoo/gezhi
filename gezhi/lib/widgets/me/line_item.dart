import 'package:flutter/material.dart';




class LineItem extends StatelessWidget {
  static void _doNothing(BuildContext context) {}
  final String tit;
  final Widget widget;
  final Function onTabFn;
  LineItem({required this.tit, required this.widget, this.onTabFn = _doNothing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 解决点击区域过小的问题
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Text(
              tit,
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget,
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onTabFn(context);
      },
    );
  }
}
