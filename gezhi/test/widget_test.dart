import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<Widget> imageList = List();

  @override
  void initState() {
    imageList
      ..add(Image.network(
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2726034926,4129010873&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3485348007,2192172119&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2594792439,969125047&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=190488632,3936347730&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Container(
          height: screenHeight * 0.3,
        )
      ],
    );
  }
}
