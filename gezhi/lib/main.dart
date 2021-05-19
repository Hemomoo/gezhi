import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gezhi/pages/error/404.dart';
import 'package:gezhi/pages/index.dart';
import 'package:provider/provider.dart';
import 'package:gezhi/providers/me/me.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gezhi/pages/login/login.dart';s

import 'package:gezhi/sqlite/init_databasee.dart';

// 路由
import 'package:gezhi/routes/route.dart';
import 'package:gezhi/style/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 使用了async/ await 异步的解决办法
  final initDatabase = InitDatabase();
  await initDatabase.init(); // 每次进来的时候初始化数据s

  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Me>(create: (context) => Me()),
      ],
      child: MaterialApp(
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
          // initialRoute: '/home',
          home: IndexPage({'currentIndex': 0}),
          // routes: new Routes(context).routes,
          onGenerateRoute: onGenerateRoute,
          //错误的路由跳转到404
          onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => PageNotFound())),
    );
  }
}
