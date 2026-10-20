import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/me/appbar.dart';

class EditPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '修改密码',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: MeAppbar(),
        actions: [
          GestureDetector(
            child: Center(
              child: Text(
                '存储',
                style: TextStyle(
                  color: GZColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            onTap: () {},
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: '当前密码',
                    hintText: '请输入密码',
                    border: InputBorder.none),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    '忘记密码？',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/me/reset_password');
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: '新密码',
                    hintText: '请新密码',
                    border: InputBorder.none),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: '确认新密码',
                    hintText: '请新密码',
                    border: InputBorder.none),
              )
            ],
          )),
    );
  }
}
