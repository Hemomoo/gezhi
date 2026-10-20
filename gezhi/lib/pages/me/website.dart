import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Website extends StatefulWidget {
  @override
  State<Website> createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.146 Safari/537.36')
      ..loadRequest(Uri.parse('https://griddiaryapp.com/zh/'));
  }

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
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
