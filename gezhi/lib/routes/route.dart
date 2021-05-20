import 'package:flutter/material.dart';
import 'package:gezhi/config.dart';

// page
import 'package:gezhi/pages/index.dart';
import 'package:gezhi/pages/me/edit_model_library.dart';
import 'package:gezhi/pages/me/index.dart';
import 'package:gezhi/pages/login/login.dart';
import 'package:gezhi/pages/login/survey.dart';
import 'package:gezhi/pages/me/about.dart';

import 'package:gezhi/pages/me/account.dart';
import 'package:gezhi/pages/me/backup_restore.dart';
import 'package:gezhi/pages/me/edit_password.dart';
import 'package:gezhi/pages/me/help.dart';
import 'package:gezhi/pages/me/hint_library.dart';
import 'package:gezhi/pages/me/model_library.dart';
import 'package:gezhi/pages/me/reset_password.dart';
import 'package:gezhi/pages/me/famous_library.dart';
import 'package:gezhi/pages/me/data.dart';
import 'package:gezhi/pages/me/setting.dart';
import 'package:gezhi/pages/time_line/time_line_diary.dart';
import 'package:gezhi/pages/time_line/revised_diary.dart';
import 'package:gezhi/pages/me/batch_export.dart';
import 'package:gezhi/pages/me/storage.dart';
import 'package:gezhi/pages/me/website.dart';
import 'package:gezhi/pages/time_line/revised_diary.dart';

//搜索
import 'package:gezhi/pages/search/img_list.dart';

final routes = {
  '/home': (BuildContext context, {arguments}) => IndexPage(arguments), // 首页
  '/login': (BuildContext context, {arguments}) => Login(), // 登录页
  '/survey': (BuildContext context, {arguments}) => Survey(),
  //我的
  '/me': (BuildContext context, {arguments}) => Me(),
  '/me/account': (BuildContext context, {arguments}) => Account(), // 账号
  '/me/hint_library': (BuildContext context, {arguments}) => HintLibrary(), // 提示库
  '/me/edit_password': (BuildContext context, {arguments}) => EditPassword(), // 修改密码
  '/me/reset_password': (BuildContext context, {arguments}) => ResetPassword(), // 修改密码
  '/me/famous_library': (BuildContext context, {arguments}) => FamousLibrary(), // 名言库
  '/me/data': (BuildContext context, {arguments}) => MeData(), // 数据
  '/me/backup_restore': (BuildContext context, {arguments}) => BackupRestore(), // 备份与恢复
  '/me/setting': (BuildContext context, {arguments}) => Setting(), //设置
  '/me/help': (BuildContext context, {arguments}) => Help(), // 帮助
  '/me/model': (BuildContext context, {arguments}) => ModelLibrary(), // 模块
  '/me/about': (BuildContext context, {arguments}) => About(), // 关于
  '/me/batch_export': (BuildContext context, {arguments}) => BatchExport(), // 数据导出
  '/me/storage': (BuildContext context, {arguments}) => Storage(), // 存储空间
  '/me/website': (BuildContext context, {arguments}) => Website(), // 网站
  '/me/edit_model_library': (BuildContext context, {arguments}) => EditModelLibrary(), // 修改模板

  /* 时间线 */
  '/time_line/time_line_diary': (BuildContext context, {arguments}) => TimeLineDiary(),
  '/time_line/revised_diary': (BuildContext context, {arguments}) => RevisedDiary(arguments: arguments),

  //搜索
  '/search/img_list': (BuildContext context, {arguments}) => ImgList(),

  //  网站
}; // 修改日记

// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  // 获取声明的路由页面函数
  var pageBuilder = routes[settings.name];
  print('跳转到那个页面${routes[settings.name]}');
  if (pageBuilder != null) {
    if (settings.arguments != null) {
      // 创建路由页面并携带参数
      return MaterialPageRoute(builder: (context) => pageBuilder(context, arguments: settings.arguments));
    } else {
      return MaterialPageRoute(builder: (context) => pageBuilder(context));
    }
  }
  return MaterialPageRoute(builder: (context) => IndexPage({'currentIndex': 0}));
};
