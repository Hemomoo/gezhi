import 'package:flutter/material.dart';

// page
import 'package:gezhi/pages/index.dart';
import 'package:gezhi/pages/login/login.dart';
import 'package:gezhi/pages/login/survey.dart';

class Routes {
  final context;
  Routes(this.context);
  Map<String, WidgetBuilder> routes = {
    '/home': (BuildContext context) => IndexPage(), // 首页
    '/login': (BuildContext context) => Login(), // 登录页
    '/survey': (BuildContext context) => Survey(),
  };
}
