import 'package:flutter/material.dart';


class PositionItem extends StatefulWidget {
  PositionItem({this.tit});
  final String tit;

  @override
  _PositionItemState createState() => _PositionItemState(tit:this.tit);
}

class _PositionItemState extends State<PositionItem> {
  final String tit;
  _PositionItemState({this.tit});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(icon: Icon(Icons.remove_circle), onPressed: () => {

              }),
              Icon(Icons.date_range),
              // Icon(Icons.date_range),
              Text(tit)
            ],
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => {print('点击了设置')}),
              Icon(Icons.menu)
            ],
          )
        ],
      ),
    );
  }
}