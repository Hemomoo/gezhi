import 'package:flutter/material.dart';
import 'package:gezhi/widgets/home/diary_setting.dart';

class DiaryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 40,
          child: InkWell(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/imgs/diary-bg.jpg',
                        width: 20,
                        height: 100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text('日记本'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('701'), Icon(Icons.arrow_forward_ios)],
                  )
                ],
              ),
            ),
            onTap: () {
              _editDiary1(context);
            },
          ),
        );
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.black54);
      },
    );
  }

  _editDiary1(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // 全屏幕展示
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
            ),
            child: DiarySetting(),
          ),
        );
      },
    );
  }
}
