import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:gezhi/pages/index.dart';

class DiarySetting extends StatefulWidget {
  const DiarySetting({Key key}) : super(key: key);

  @override
  _DiarySettingState createState() => _DiarySettingState();
}

class _DiarySettingState extends State<DiarySetting> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Icon(Icons.check_circle),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            '日记本设置',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(8),
            ),
            padding: EdgeInsets.all(0.0),
            onSelected: (val) {
              if (val == 'copy') {
                Clipboard.setData(ClipboardData(text: val)).then(
                  (value) => {
                    Toast.show("复制成功", context),
                  },
                );
              } else {
                // 跳转到首页，关闭所有路由的页面
                Navigator.of(context)
                    .pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => IndexPage({'currentIndex': 0})), (route) => route == null);
              }
            },
            icon: Icon(Icons.more_horiz),
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'copy',
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.content_copy),
                      Text('拷贝日记本ID'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever),
                      Text('删除日记本'),
                    ],
                  ),
                )
              ];
            },
          )
        ],
      ),
    );
  }
}
