import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Website extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          '网站',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: 'https://griddiaryapp.com/zh/',
          userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.146 Safari/537.36',
          javascriptMode: JavascriptMode.unrestricted, // 允许使用js,可以用页面上的事件
        ),
      ),
    );
  }
}
