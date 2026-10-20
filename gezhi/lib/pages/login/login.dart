import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gezhi/style/style.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late List<String> imageList;
  int _currentIndex = 0;

  @override
  void initState() {
    imageList = [
      'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2726034926,4129010873&fm=26&gp=0.jpg',
      'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3485348007,2192172119&fm=26&gp=0.jpg',
      'http://ppe.oss-cn-shenzhen.aliyuncs.com/palette/480314/1596695976584/thumb_Thu_Aug_06_2020.jpg',
      'http://ppe.oss-cn-shenzhen.aliyuncs.com/palette/480314/1596695096677/thumb_Thu_Aug_06_2020.jpg'
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Swiper(
            itemCount: imageList.length,
            itemBuilder: _swiperBuilder,
            pagination: SwiperPagination(
              alignment: Alignment(0.0, 0.8),
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
              builder: DotSwiperPaginationBuilder(
                color: Colors.black54,
                activeColor: Colors.white,
              ),
            ),
            controller: SwiperController(),
            scrollDirection: Axis.horizontal,
            // autoplay: true,
            onTap: (index) => {
              setState(
                () {
                  _currentIndex = index;
                },
              )
            },
          ),
        ),
        Positioned(
          bottom: 20,
          // left: 42,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ElevatedButton(
                    // child: GZColors.primary,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "开始",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/survey');
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // 首页轮播图
  Widget _swiperBuilder(BuildContext context, int index) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageList[index]), fit: BoxFit.cover),
      ),
    );
  }
}

