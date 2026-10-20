import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gezhi/widgets/me/appbar.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isVideo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: MeAppbar(),
        title: Text(
          '设置',
          style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _settingItm(tit: '密码锁'),
            _settingItm(
                tit: '提醒',
                leading: Text(
                  '无',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            _settingItm(tit: '照片'),
            _settingItm(tit: '样式编辑器'),
            _settingItm(tit: '外观'),
            _settingItm(
                tit: '音效',
                leading: CupertinoSwitch(
                  value: _isVideo,
                  onChanged: (bool newVal) {
                    setState(() {
                      _isVideo = newVal;
                    });
                  },
                )),
            _settingItm(tit: '日历'),
            _settingItm(tit: '小组件'),
            _settingItm(tit: '语言'),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'App启动',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),
                        ),
                      )),
                  _settingItm(tit: '打开日记本', leading: Text('日记本',style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingItm({required String tit, Widget? leading, Function? fn}) {
    return ListTile(
      title: Text(
        tit,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
              leading == null ? Text('') : leading,
              SizedBox(width: (leading is! CupertinoSwitch) ? 10:0,),
              (leading is! CupertinoSwitch) ? Icon(Icons.arrow_forward_ios,size: 18,):SizedBox(width: 0,),
            ]
        ),
      ),
      onTap: () {
        fn?.call();
      },
    );
  }
}
