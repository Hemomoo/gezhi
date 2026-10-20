import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  bool isBut = false;
  void onChanged(val) {
    setState(() {
      isBut = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '1/2',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '你想要通过日记实现什么目标？',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SelctedWidget(callBack: (value) => onChanged(value), key: const Key('selected_widget')),
              ],
            ),
            Positioned(
              bottom: 20,
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: isBut ? Colors.black87 : Colors.black38,
                  ),
                  child: Center(
                    child: Text(
                      '继续',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // Navigator.of(context).pushNamed('/survey');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelctedWidget extends StatefulWidget {
  SelctedWidget({required Key key, this.callBack}) : super(key: key);
  final callBack;
  @override
  _SelctedWidgetState createState() => _SelctedWidgetState();
}

class _SelctedWidgetState extends State<SelctedWidget> {
  List<Map<String, dynamic>> tipList = [
    {
      "title": "记录生活",
      "isSel": false,
    },
    {
      "title": "练习自我关爱",
      "isSel": false,
    },
    {
      "title": "养成习惯",
      "isSel": false,
    },
    {
      "title": "实现目标",
      "isSel": false,
    },
    {
      "title": "掌握生活平衡",
      "isSel": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tipList.asMap().keys.map(
        (index) {
          return InkWell(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: tipList[index]['isSel']
                    ? Border.all(color: GZColors.primary, width: 2)
                    : Border.all(color: Colors.transparent, width: 2),
                borderRadius: new BorderRadius.circular(
                  (10.0),
                ),
              ),
              child: Text(
                tipList[index]['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color:
                      tipList[index]['isSel'] ? GZColors.primary : Colors.black,
                ),
              ),
            ),
            onTap: () {
              widget.callBack(true);
              setState(
                () {
                  tipList = tipList.map((e) {
                    if (e['title'] == tipList[index]['title']) {
                      e['isSel'] = true;
                    } else {
                      e['isSel'] = false;
                    }
                    return e;
                  }).toList();
                },
              );
            },
          );
        },
      ).toList(),
    );
  }
}
