import 'package:flutter/material.dart';
import 'package:gezhi/widgets/search/search_bar.dart';
import 'package:gezhi/widgets/search/statistics.dart';
import 'package:gezhi/widgets/search/img_box.dart';
import 'package:gezhi/widgets/search/headline.dart';
import 'package:gezhi/widgets/search/tags.dart';
import 'package:gezhi/widgets/search/year.dart';
import 'package:gezhi/widgets/search/index/grid.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12, // 整个页面的背景颜色
      appBar: AppBar(
        title: new Center(
          child: new Text(
            '搜索',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [SearchBar(), RecordGrid(), Statistics(), _sizeBox(), ImgBox(), _sizeBox(), Heading(), _sizeBox(), Tags(), _sizeBox(), Year()],
          ),
        ),
      ),
    );
  }

  Widget _sizeBox() {
    return SizedBox(
      height: 20,
      width: double.infinity,
    );
  }
}
