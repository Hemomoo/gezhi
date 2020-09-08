import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezhi/widgets/me/appbar.dart';

class MeData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          '数据',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: MeAppbar(tit: '我'),
      ),
      body: Container(
//        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                title: Text(
                  '备份与回复',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('数据快照、JSON',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.pushNamed(context, '/me/backup_restore');
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                title: Text(
                  '批量导出',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('将日记导出为文本、PDF或印象笔记',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            Column(
              children: [
                _dataItem('导入数据'),
                _dataItem('从格志经典版迁出'),
                _dataItem('存储空间'),
                _dataItem('诊断'),
                _dataItem('数据指南'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _dataItem(String tit, {Function fn}) {
    return ListTile(
        title: Text(
          tit,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          fn();
        });
  }
}
