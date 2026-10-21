import 'package:flutter/material.dart';

/// 日记本封面卡片
class DiaryBookCard extends StatelessWidget {
  const DiaryBookCard({super.key, this.title = '日记本'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 150,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/imgs/diary-bg.jpg',
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black12,
                padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
