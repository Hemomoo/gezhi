import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/time_line/listing_item.dart';
import 'package:gezhi/widgets/time_line/grid_item.dart';

//字体图标
import 'package:gezhi/fonts/font.dart';

class TimeLineDiary extends StatefulWidget {
  @override
  _TimeLineDiaryState createState() => _TimeLineDiaryState();
}

class _TimeLineDiaryState extends State<TimeLineDiary> {
  final List<Map<String, dynamic>> _itemList = [
    {
      'icon': Icons.arrow_upward,
      'tit': '导出日记',
      'isArrow': true,
    },
    {
      'icon': Icons.content_paste,
      'tit': '拷贝为',
      'isArrow': true,
    },
    {
      'icon': Icons.content_copy,
      'tit': '拷贝到...',
      'isArrow': false,
    },
    {
      'icon': Icons.receipt,
      'tit': '移动到...',
      'isArrow': false,
    },
    {
      'icon': Icons.error_outline,
      'tit': '查看日记详情',
      'isArrow': false,
    },
    {
      'icon': Icons.delete_forever,
      'tit': '删除日记',
      'isArrow': false,
    }
  ];

  bool _isGrid = true;
  bool _isListing = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop('返回'); // 传过去的值
        return Future.value(true); // true 跳转 false 不跳转
      },
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color(0XFFe7e7eb),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _isGrid ? Colors.white : Color(0XFFe7e7eb),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.border_all,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isGrid = true;
                      _isListing = false;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _isListing ? Colors.white : Color(0XFFe7e7eb),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.sort,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isGrid = false;
                      _isListing = true;
                    });
                  },
                )
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/time_line/revised_diary',
                    arguments: <String, dynamic>{},
                  );
                }),
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                _showBottom();
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '26',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '星期三',
                              style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '2020年8月',
                              style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: _isGrid
                        ? GestureDetector(
                            child: Row(
                              children: [
                                Icon(
                                  IconFont.icon_taiyang,
                                  size: 26,
                                  color: Colors.black38,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6, right: 10),
                                  child: Icon(IconFont.icon_smile, size: 20, color: Colors.black38),
                                ),
                                Icon(IconFont.icon_tag, size: 16, color: Colors.black38),
                              ],
                            ),
                            onTap: () {},
                          )
                        : Row(
                            children: [
                              Icon(
                                Icons.book,
                                color: Colors.black12,
                              ),
                              Text(('日记本'))
                            ],
                          ),
                  ),
                ],
              ),
            ),
            _isGrid ? GridItem() : ListingItem()
          ],
        ),
      ),
    );
  }

  void _showBottom() {
    showModalBottomSheet(
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(
                    _itemList[index]['tit'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  leading: Icon(
                    _itemList[index]['icon'],
                    color: GZColors.primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: _itemList[index]['isArrow'] ? Colors.black38 : Colors.transparent,
                    size: 16,
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return index == 1 || index == 3 || index == 4
                  ? Divider(
                      color: Colors.black12,
                    )
                  : Divider(
                      color: Colors.transparent,
                    );
            },
            itemCount: _itemList.length,
          ),
        );
      },
    );
  }

  // 导出
  void _exportMode() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      builder: (BuildContext context) {
        return Container();
      },
    );
  }
}
