import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/time_line/listing_item.dart';
import 'package:gezhi/widgets/time_line/grid_item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gezhi/widgets/common/common.dart';
import 'package:gezhi/widgets/time_line/label_widget.dart';
import 'package:gezhi/widgets/time_line/paster.dart';

//字体图标
import 'package:gezhi/fonts/font.dart';

class TimeLineDiary extends StatefulWidget {
  final Map<String, dynamic> arguments;
  TimeLineDiary({this.arguments});

  @override
  _TimeLineDiaryState createState() => _TimeLineDiaryState(arguments);
}

class _TimeLineDiaryState extends State<TimeLineDiary> {
  final Map<String, dynamic> arguments;
  _TimeLineDiaryState(this.arguments);

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

  PageController _pageController = PageController();
  List<String> weekList = ['一', '二', '三', '四', '五', '六', '日'];

  bool _isGrid = true;
  bool _isListing = false;
  int day; // 日期
  int weekday; // 星期几

  @override
  void initState() {
    day = int.parse(widget.arguments['date'].split('-').last);
    weekday = int.parse(weekList[DateTime.parse(widget.arguments['date']).weekday - 1]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop('返回'); // 传过去的值
        return Future.value(true); // true 跳转 false 不跳转
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                _showBottom();
              },
            )
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (page) {
            print(page);
            day = day + 1;
            weekday = weekday +1;

            setState(() {});
          },
          itemBuilder: (BuildContext context, index) {
            return Column(
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
                              day.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '星期${}',
                                  style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.arguments['date'],
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
                                child: GestureDetector(
                                  onTap: () {
                                    _stickersLabels();
                                  },
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
                _isGrid ? GridItem(widget.arguments['date']) : ListingItem()
              ],
            );
          },
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(14),
              topLeft: Radius.circular(14),
            ),
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

  //贴纸和标签
  void _stickersLabels() {
    int _currentIndex = 0;
    Color _color = Colors.black;
    PageController _pageController = PageController(initialPage: 0);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      topLeft: Radius.circular(14),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: CommonWidget.line(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _currentIndex = 0;
                                  _pageController.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                                  state(() {});
                                },
                                child: Container(
                                  width: 48,
                                  height: 48.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '贴纸',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: _currentIndex == 0 ? Colors.black : Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _currentIndex = 1;
                                  _pageController.animateToPage(1, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                                  state(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '标签',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: _currentIndex == 1 ? Colors.black : Colors.black54,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          _currentIndex == 1
                              ? AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  child: PopupMenuButton(
                                    padding: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(8),
                                    ),
                                    onSelected: (value) {},
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: _color,
                                    ),
                                    itemBuilder: (context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: '新建标签',
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.library_add, color: GZColors.primary),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('新建标签'),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: '管理标签',
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.create, color: GZColors.primary),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('管理标签'),
                                            ],
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                )
                              : Container(
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: Colors.transparent,
                                  ),
                                )
                        ],
                      ),
                      Expanded(
                        child: PageView.builder(
                          itemCount: 2,
                          onPageChanged: (int index) {
                            _color = index == 0 ? Colors.transparent : Colors.black;
                            _currentIndex = index;
                            FocusScope.of(context).requestFocus(FocusNode()); // 关闭键盘
                            state(() {});
                          },
                          // DrivenScrollActivity
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Paster();
                            } else {
                              return LabelWidget();
                            }
                          },
                        ),
                      )
                    ],
                  ));
            },
          );
        });
  }

  // 导出
  void _exportMode() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
