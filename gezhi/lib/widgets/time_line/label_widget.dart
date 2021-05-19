// label widget 页面

import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';

class LabelWidget extends StatefulWidget {
  const LabelWidget({Key key}) : super(key: key);

  @override
  _LabelWidgetState createState() => _LabelWidgetState();
}

class _LabelWidgetState extends State<LabelWidget> {
  FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isCancel = true;
  List<Map> labelList = [
    {
      'id': '1',
      'label': '生活',
      'isSel': false,
    },
    {
      'id': '2',
      'label': '工作',
      'isSel': false,
    },
    {
      'id': '3',
      'label': '学习',
      'isSel': false,
    }
  ];

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        isCancel = false;
      } else {
        isCancel = true;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  // padding: EdgeInsets.all(4),
                  // width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: TextField(
                          key: _formKey,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            hintText: "搜索标签",
                            border: InputBorder.none, // 去掉下滑线
                            counterText: '', // 去除输入框底部的字符计数
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isCancel
                  ? SizedBox(
                      width: 0,
                    )
                  : GestureDetector(
                      onTap: () {
                        _focusNode.unfocus();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '取消',
                          style: TextStyle(color: GZColors.primary),
                        ),
                      ),
                    )
            ],
          ),
          Column(
            children: _labelWidgetList(),
          )
        ],
      ),
    );
  }

  List<Widget> _labelWidgetList() {
    return labelList
        .asMap()
        .map((index, e) {
          return MapEntry(
            index,
            GestureDetector(
              onTap: () {
                labelList[index]["isSel"] = !labelList[index]["isSel"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Transform.rotate(angle: 10, child: Icon(Icons.label, color: e['isSel'] ? GZColors.primary : Colors.black26)),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                e['label'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Icon(
                                Icons.check,
                                size: 22,
                                color: e['isSel'] ? GZColors.primary : Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        })
        .values
        .toList();
  }
}
