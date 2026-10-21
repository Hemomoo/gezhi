import 'package:flutter/material.dart';

/// 添加小部件弹窗中的可排序条目
class PositionItem extends StatefulWidget {
  PositionItem({required this.tit, required this.index, required Key key})
      : super(key: key);

  final String tit;
  final int index;

  @override
  _PositionItemState createState() =>
      _PositionItemState(tit: this.tit, index: this.index);
}

class _PositionItemState extends State<PositionItem> {
  final String tit;
  final int index;
  bool isDel = false;

  _PositionItemState({required this.tit, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      isDel = !isDel;
                    });
                  }),
              Icon(Icons.date_range),
              Text(tit)
            ],
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => {print('点击了设置')}),
              Icon(Icons.menu),
              isDel
                  ? Container(
                      alignment: Alignment.center,
                      width: 40,
                      child: Text('移除'),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
