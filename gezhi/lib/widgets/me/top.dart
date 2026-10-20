import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  String avatar = '';
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      prefs = await SharedPreferences.getInstance();
      avatar = prefs.getString('avatar') ?? '';
      if (mounted) setState(() {});
    });
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
            child: avatar.isEmpty
                ? Container(
                    width: 50,
                    height: 50,
                    color: Colors.black12,
                    child: Icon(
                      Icons.person,
                      color: Colors.white38,
                    ),
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
