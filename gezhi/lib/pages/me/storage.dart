//存储空间

import 'package:flutter/material.dart';

class Storage extends StatefulWidget {
  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '存储空间',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            _storageListWidget(title: '数据库', trailingTex: '70.25M'),
            _storageListWidget(title: '文档', trailingTex: '4.3kb'),
            _storageListWidget(title: '缓存', trailingTex: '234.56M'),
            _storageListWidget(
                title: '清除缓存',
                trailing: Icon(Icons.delete),
                fn: () {
                  print('清除缓存');
                })
          ],
        ),
      ),
    );
  }

  Widget _storageListWidget({required String title, String? trailingTex, Widget? trailing, Function? fn}) {
    return ListTile(
      title: Text(title),
      trailing: trailing == null ? Text(trailingTex ?? '') : trailing,
      onTap: () {
        fn?.call();
      },
    );
  }
}
