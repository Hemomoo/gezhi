import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:gezhi/sqlite/sql_common.dart';

class CustomNotification extends Notification {
  CustomNotification(this.msg);
  final String msg;
}

class GridItem extends StatefulWidget {
  final String date;

  GridItem(this.date, {Key key}) : super(key: key);
  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  List<Map<String, dynamic>> diaryList = [];
  final SqlUtil diarySql = SqlUtil.setTable('diary');

  //获取数据
  Future getDiaryList(date) async {
    List<Map<String, dynamic>> response;
    response = await diarySql.rawQuery('SELECT * FROM diary WHERE date = ' + ' "$date"', null);
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    //获取今天的数据
    print('ksjd');
    getDiaryList(widget.date).then((value) {
      diaryList = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
          childAspectRatio: 1.15,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.black12),
                    right: BorderSide(
                      width: index % 2 == 0 ? 0.5 : 0,
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diaryList.length - 1 >= index ? diaryList[index]['tip'] : '',
                      maxLines: 3,
                      style: TextStyle(),
                    ),
                    Text(
                      diaryList.length - 1 >= index ? diaryList[index]['diaryInfo'] : '',
                    )
                  ],
                )),
            onTap: () {
              Navigator.pushNamed(context, '/time_line/revised_diary', arguments: {'index': index, 'date': widget.date}).then((value) {
                CustomNotification("Hi").dispatch(context);
                // print('>>>${value}');
              });
            },
          );
        },
      ),
    );
  }
}
