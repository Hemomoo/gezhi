import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezhi/widgets/me/appbar.dart';
import 'package:gezhi/widgets/me/line_item.dart';
import 'package:image_picker/image_picker.dart';

class Account extends StatelessWidget {
  final TextStyle _textStyle = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: MeAppbar(tit: '我'),
        centerTitle: true,
        title: Text(
          '账户',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: InkWell(
              child: Text(
                '登出',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {showAlertDialog(context)},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        primary: false,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: _personInfo(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: _account(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: _signInWith(),
              ),
              Container(
                child: Text(
                  '于2018年10月15日加入格志',
                  style: TextStyle(color: Colors.black26, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 个人资料
  Widget _personInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '个人资料',
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        LineItem(
          tit: '头像',
          widget: ClipOval(
            child: Image.network(
              'https://img.cc0.cn/pixabay/201910282316374919.jpg/content',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          onTabFn: _imgSel,
        ),
        LineItem(
          tit: '名字',
          widget: Text(
            '何默',
            style: _textStyle,
          ),
        ),
      ],
    );
  }

  // 账户
  Widget _account() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '账户',
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        LineItem(
            tit: '邮箱',
            widget: Text(
              '787615673@qq.com',
              style: _textStyle,
            )),
        LineItem(
          tit: '密码',
          widget: Text(''),
          onTabFn: (context) {
            Navigator.pushNamed(context, '/me/edit_password');
          },
        ),
      ],
    );
  }

  // 第三方登录
  Widget _signInWith() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '第三方登录',
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        LineItem(
            tit: '苹果',
            widget: Text(
              '绑定',
              style: _textStyle,
            )),
        LineItem(tit: '谷歌', widget: Text('绑定', style: _textStyle)),
        LineItem(tit: '微信', widget: Text('绑定', style: _textStyle)),
      ],
    );
  }

  // 弹出层
  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          content: Text(
            '你真的要退出吗？',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Container(
              width: double.maxFinite, // 充满父元素
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('确定'),
                  ),
                  Container(
                    width: 1,
                    color: Colors.black12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('取消'),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  // 照片选择底部弹窗
  void _imgSel(BuildContext context) {
    final TextStyle _textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.transparent,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.black12,
                  width: double.infinity,
                  child: ListTile(
                    title: Text(
                      '选取图片',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('拍照', style: _textStyle),
                  onTap: () {
                    picker.pickImage(source: ImageSource.camera);
                  },
                ),
                ListTile(
                  title: Text(
                    '从相册中选择',
                    style: _textStyle,
                  ),
                  onTap: () {
                    picker.pickImage(source: ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  // 发送修改邮件的邮箱
  void _sendEmail(BuildContext context) {}
}
