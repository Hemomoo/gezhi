// 备份与恢复

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gezhi/widgets/me/appbar.dart';

class BackupRestore extends StatefulWidget {
  @override
  _BackupRestoreState createState() => _BackupRestoreState();
}

class _BackupRestoreState extends State<BackupRestore> {
  bool _isSnap = true; // 是不是自动创建快照
  bool _isStorage = true; // 是不是不是

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: MeAppbar(
          tit: '',
        ),
        title: Text(
          '备份与恢复',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.error_outline,
                  color: Colors.black,
                )),
            onTap: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        child: Text(
                          '数据快照',
                          style: TextStyle(color: Colors.black38),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    _item(
                        tit: '快照',
                        subTit: '''位置:iCloud | 数量: 22 ''',
                        itemIcon: Icons.arrow_forward_ios,
                        size: 16),
                    _item(
                      tit: '快照创建',
                      subTit: '''上次创建： 刚刚''',
                      itemIcon: Icons.add_box,
                    ),
                    _item(
                      tit: '从快照还原',
                      itemIcon: Icons.refresh,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        child: Text(
                          '偏好设置',
                          style: TextStyle(color: Colors.black38),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16.0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('自动创建快照',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          CupertinoSwitch(
                            value: _isSnap,
                            onChanged: (bool newVal) {
                              setState(() {
                                _isSnap = newVal;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('用iCloud存储',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          CupertinoSwitch(
                            value: _isStorage,
                            onChanged: (bool newVal) {
                              setState(() {
                                _isStorage = newVal;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                          '为了让你的数据更加安全，格志可以每天自动创建数据快照，并将其保存到iCloud上。自动创建的额快照只会保留最新的30分钟'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        child: Text(
                          'JSON',
                          style: TextStyle(color: Colors.black38),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    _item(tit: '导出JSON', itemIcon: Icons.arrow_upward),
                    _item(
                      tit: '导入JSON',
                      itemIcon: Icons.arrow_downward,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile _item(
      {required String tit,
      String subTit = "",
      IconData? itemIcon,
      Function? fn,
      double? size}) {
    return ListTile(
      title: Text(
        tit,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(subTit),
      trailing: Icon(
        itemIcon,
        size: size,
      ),
      onTap: () {
        fn?.call();
      },
    );
  }
}
