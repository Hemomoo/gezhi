import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  late String avatar;
  late SharedPreferences prefs;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      prefs = await SharedPreferences.getInstance();
      avatar = prefs.getString('avatar')!;
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '何默',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '格志日记会员',
                style: TextStyle(color: Colors.black38),
              ),
            ],
          ),
          ClipOval(
            child: avatar == null
                ? Image.network(
                    'https://img.cc0.cn/pixabay/201910282316374919.jpg/content',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(avatar),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
          )
        ],
      ),
    );
  }
}
