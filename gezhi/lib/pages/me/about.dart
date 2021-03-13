import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezhi/widgets/me/appbar.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: MeAppbar(),
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Center(
                child: Text(
                  '分享',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                'assets/imgs/bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
            _aboutItem(
              tit: '版本',
              trailing: Text(
                '1.75(153)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),
              ),
            ),
            _aboutItem(
                tit: '网站',
                fn: () {
                  Navigator.pushNamed(context, '/me/website');
                }),
            _aboutItem(tit: '使用的库'),
            _aboutItem(tit: '隐私条款'),
            _aboutItem(tit: '使用协议')
          ],
        ),
      ),
    );
  }

  Widget _aboutItem({@required String tit, Widget trailing, Function fn}) {
    return ListTile(
      title: Text(tit, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      trailing: (trailing is Text) ? trailing : Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        fn();
      },
    );
  }
}
