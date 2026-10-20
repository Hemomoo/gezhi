

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:gezhi/pages/index.dart';

class DiarySetting extends StatefulWidget {
  const DiarySetting({required Key key}) : super(key: key);

  @override
  _DiarySettingState createState() => _DiarySettingState();
}

class _DiarySettingState extends State<DiarySetting> {

  final TextStyle itemTextStyle = TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black54);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
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
                    Clipboard.setData(ClipboardData(text: val as String)).then(
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Setting('标题',Text(('日记本'),style:itemTextStyle)),
                  Setting('封面图',Image.asset('assets/imgs/diary-bg.jpg',width: 80,height: 100,)),
                  Setting('类型',Row(
                    children: [
                      Icon(Icons.tag_faces),
                      Icon(Icons.sentiment_satisfied_alt),
                      Icon(Icons.sentiment_neutral),
                      Icon(Icons.mood_bad),
                    ],
                  ),isBottomBorder:true),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text('模板'),
                      Setting('日',Text(('默认日模板'),style:itemTextStyle)),
                      Setting('周',Text(('默认周模板'),style:itemTextStyle)),
                      Setting('月',Text(('默认月模板'),style:itemTextStyle)),
                      Setting('年',Text(('默认年模板'),style:itemTextStyle),isBottomBorder:true),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



class Setting extends StatelessWidget {
  final String tit;
  final Widget widget;
  final bool isBottomBorder;
  
  Setting(this.tit,this.widget,{this.isBottomBorder = false});
  
  
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
          color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12),
          bottom: isBottomBorder?BorderSide(color: Colors.black12):BorderSide(color: Colors.transparent),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tit,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Row(
            children: [
              widget,
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.arrow_forward_ios,color: Colors.black38,size: 18.0,),
              )
            ],
          )
        ],
      ),
    );
  }
}



