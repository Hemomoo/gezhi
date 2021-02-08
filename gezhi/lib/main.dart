import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gezhi/pages/error/404.dart';
import 'package:gezhi/pages/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gezhi/pages/login/login.dart';

import 'package:gezhi/sqlite/init_databasee.dart';

// 路由
import 'package:gezhi/routes/route.dart';
import 'package:gezhi/style/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 使用了async/ await 异步的解决办法
  final initDatabase = InitDatabase();
  await initDatabase.init(); // 每次进来的时候初始化数据

  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '格志日记',
        debugShowCheckedModeBanner: false, // 取消debug
        theme: ThemeData(
          highlightColor: Color.fromARGB(0, 0, 0, 0),
          splashColor: Color.fromARGB(0, 0, 0, 5),
          primaryColor: Color(0xFF32C4CC),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(),
        ),
        home: IndexPage(),
        // routes: new Routes(context).routes,
        onGenerateRoute: onGenerateRoute,
        //错误的路由跳转到404
        onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => PageNotFound()));
  }
}
