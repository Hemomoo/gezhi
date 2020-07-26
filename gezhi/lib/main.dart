import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gezhi/pages/index.dart';

void main() {
  debugPaintSizeEnabled = !true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Color.fromARGB(0, 0, 0, 0),
        splashColor: Color.fromARGB(0, 0, 0, 5),
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IndexPage(),
    );
  }
}
