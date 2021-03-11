import 'package:flutter/material.dart';

//图片列表widget
class ImgList extends StatefulWidget {
  @override
  _ImgListState createState() => _ImgListState();
}

class _ImgListState extends State<ImgList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text('图库'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _imgCarousel(context, 'https://seaside-station.com/wpbin/wp-content/uploads/hizen-iida_01.jpg');
              },
              child: Container(
                child: Stack(children: [
                  Image.network(
                    'https://seaside-station.com/wpbin/wp-content/uploads/hizen-iida_01.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 10.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              '27',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Text(
                            '2021年2月',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }

  void _imgCarousel(BuildContext context, String imgUrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true, // 全屏幕展示
      builder: (BuildContext context) {
        //构建弹框中的内容
        return Container(
          height: double.infinity,
          child: Image.network(imgUrl),
        );
      },
    );
  }
}
