import 'package:flutter/material.dart';
import 'package:gezhi/widgets/search/top.dart';
import 'package:gezhi/widgets/common/common.dart';

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, //设置阴影
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        ),
      ),
      child: Container(
        child: Column(
          children: [
            Top(title: '标题', num: 10),
            Padding(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '年后高好高哦嘎搞个骄傲和高拱爱忽高忽低发号活动发哈单号回到哈哈好地方哈哈忽高忽低发号活动发哈单号回到哈哈好地方忽高忽低发号活动发哈单号回到哈哈好地方',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('12121')
                      ],
                    ),
                    onTap: () => {print('12121')},
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return CommonWidget.divider;
                },
                itemCount: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
