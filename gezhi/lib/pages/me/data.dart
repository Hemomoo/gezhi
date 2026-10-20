import 'package:flutter/material.dart';
import 'package:gezhi/widgets/me/appbar.dart';

class MeData extends StatefulWidget {
  @override
  _MeDataState createState() => _MeDataState();
}

class _MeDataState extends State<MeData> {
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
                subtitle: Text('数据快照、JSON', style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
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
                subtitle: Text('将日记导出为文本、PDF或印象笔记', style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, '/me/batch_export');
                },
              ),
            ),
            Column(
              children: [
                _dataItem('导入数据', fn: _importData),
                _dataItem('从格志经典版迁出'),
                _dataItem('存储空间', fn: () {
                  Navigator.pushNamed(context, '/me/storage');
                }),
                _dataItem('诊断'),
                _dataItem('数据指南'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _dataItem(String tit, {Function? fn}) {
    return ListTile(
      title: Text(
        tit,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Text('设置'),
      onTap: () {
        if (fn != null) {
          fn();
        }
      },
    );
  }

  void _importData() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 140,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  color: Colors.black12,
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('从Day One导入'),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Align(
                              child: Text('浏览文件.ZIP'),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          onTap: () {
                            print('浏览文件');
                            Navigator.of(context).pop();
                          },
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Align(
                              child: Text('帮助'),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          onTap: () {
                            print('浏览文件');
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
