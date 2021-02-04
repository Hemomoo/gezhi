import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:gezhi/widgets/me/appbar.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool _isTips = true;
  bool _isDebugLog = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: MeAppbar(),
        title: Text(
          '帮助',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _helpItem(tit: '支持中心'),
            _helpItem(tit: '联系我们'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  _helpItem(
                    tit: '显示提示',
                    leading: CupertinoSwitch(
                      value: _isTips,
                      onChanged: (bool newVal) {
                        setState(() {
                          _isTips = newVal;
                        });
                      },
                    ),
                  ),
                  _helpItem(
                    tit: '打开调试日志',
                    leading: CupertinoSwitch(
                      value: _isDebugLog,
                      onChanged: (bool newVal) {
                        setState(() {
                          _isDebugLog = newVal;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            _helpItem(tit: '提建议'),
            _helpItem(tit: '帮助我们翻译'),
            _helpItem(
                tit: '在应用商店上评分',
                fn: () => LaunchReview.launch(
                      androidAppId: "com.android.vending",
                    )),
          ],
        ),
      ),
    );
  }

  Widget _helpItem({@required String tit, Widget leading, Function fn}) {
    return ListTile(
      title: Text(
        tit,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            leading == null ? Text('') : leading,
            SizedBox(
              width: (leading is! CupertinoSwitch) ? 10 : 0,
            ),
            (leading is! CupertinoSwitch)
                ? Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  )
                : SizedBox(
                    width: 0,
                  ),
          ],
        ),
      ),
      onTap: () {
        fn();
      },
    );
  }
}
