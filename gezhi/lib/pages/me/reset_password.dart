import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/me/appbar.dart';

class ResetPassword extends StatelessWidget {
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
          '重置密码',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Center(
                child: Text(
                  '发送',
                  style: TextStyle(
                      color: GZColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('邮箱'),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                '787615673@qq.com',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '你将会收到一封邮件，请根据说明操作来重置密码',
              style: TextStyle(color: Colors.black26),
            ),
          ],
        ),
      ),
    );
  }
}
