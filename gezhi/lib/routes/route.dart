import 'package:flutter/material.dart';

// page
import 'package:gezhi/pages/index.dart';
import 'package:gezhi/pages/login/login.dart';
import 'package:gezhi/pages/login/survey.dart';

import 'package:gezhi/pages/me/account.dart';
import 'package:gezhi/pages/me/hint_library.dart';

class Routes {
  final context;
  Routes(this.context);
  Map<String, WidgetBuilder> routes = {
    '/home': (BuildContext context) => IndexPage(), // 首页
    '/login': (BuildContext context) => Login(), // 登录页
    '/survey': (BuildContext context) => Survey(),
    '/me/account': (BuildContext context) => Account(), // 账号
    '/me/hint_library': (BuildContext context) => HintLibrary(), // 提示库
  };
}
