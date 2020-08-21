import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
// import 'package:toast/toast.dart';

class DiaryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.transparent,
    );
    Widget divider2 = Divider(color: Colors.grey);
    return ListView.separated(
      itemCount: 2,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: InkWell(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.network(
                        'http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/73/8/thumb.jpg',
                        width: 20,
                        height: 100,
                      ),
                      Text('日记本'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('701'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              _editeDiary1(context);
            },
          ),
        );
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? divider1 : divider2;
      },
    );
  }

  _editeDiary1(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // 全屏幕展示
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14), topRight: Radius.circular(14)),
            ),
            child: Column(
              children: <Widget>[BottomSheetHead()],
            ),
          ),
        );
      },
    );
  }
}

class BottomSheetHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.check),
        Text(
          '日记本',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        PopupMenuButton(
          onSelected: (val) {
            Clipboard.setData(ClipboardData(text: val)).then(
              (value) => {
                Toast.show("复制成功", context),
              },
            );
          },
          icon: Icon(Icons.more_horiz),
          itemBuilder: (context) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: '14',
                child: Row(
                  children: <Widget>[
                    Icon(Icons.content_copy),
                    Text('拷贝日记本ID'),
                  ],
                ),
              )
            ];
          },
        )
      ],
    );
  }
}
