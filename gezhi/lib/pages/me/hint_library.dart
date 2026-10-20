import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:gezhi/widgets/me/appbar.dart';

import 'package:gezhi/sqlite/sql_common.dart';

import 'package:gezhi/widgets/common/common.dart';


import 'package:event_bus/event_bus.dart';



class HintLibrary extends StatefulWidget {
  @override
  _HintLibraryState createState() => _HintLibraryState();
}

class _HintLibraryState extends State<HintLibrary>
    with TickerProviderStateMixin {

  EventBus _eventBus = EventBus();



  final List<String> _tabs = ['日', '周', '月', '年'];
  List<Map<String, dynamic>> tipList = [];
  List<Map<String, dynamic>> dayTipList = [];
  List<Map<String, dynamic>> weekTipList = [];
  List<Map<String, dynamic>> monthTipList = [];
  List<Map<String, dynamic>> yearTipList = [];

  late TabController _tabController;

  final SqlUtil hintSql = SqlUtil.setTable('tips');




  @override
  void initState() {

    (() async {
      dayTipList = await hintSql.query(conditions: {'date': '日'});
      weekTipList = await hintSql.query(conditions: {'date': '周'});
      monthTipList = await hintSql.query(conditions: {'date': '月'});
      yearTipList = await hintSql.query(conditions: {'date': '年'});
      setState(() {});
    })();
    _eventBus.on().listen((event) {

      setState(() {});
      if(event){
        // 需要这样写才可以刷新页面
        (() async {
          dayTipList = await hintSql.query(conditions: {'date': '日'});
          weekTipList = await hintSql.query(conditions: {'date': '周'});
          monthTipList = await hintSql.query(conditions: {'date': '月'});
          yearTipList = await hintSql.query(conditions: {'date': '年'});
          setState(() {});
        })();
      }
    });

    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  // 页面销毁的时候
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            '提示库',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: MeAppbar(
          tit: '我',
        ),
        bottom: TabBar(
          labelColor: Colors.black,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          // indicatorPadding: EdgeInsets.symmetric(vertical: -10),
          indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
          indicatorColor: Colors.black, // 选中的颜色
          unselectedLabelColor: Colors.black38, // 没有选择的颜色
          tabs: _tabs.map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(item),
            );
          }).toList(),
          controller: _tabController,
        ),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            onSelected: (val) => {
              if (val == 'addHint') {
                _addHint(context, _tabController.index,_eventBus),
              }
            },
            offset: Offset(0, 20),
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'addHint',
                  child: Chip(
                    label: Text(
                      '新增提示',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    avatar: Icon(
                      Icons.add_to_photos,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'manageHint',
                  child: Chip(
                    label: Text(
                      '管理提示',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    avatar: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _itemList(dayTipList),
          _itemList(weekTipList),
          _itemList(monthTipList),
          _itemList(yearTipList),
        ],
      ),
    );
  }

  Widget _itemList(List<Map<String, dynamic>> dataList) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          color: Colors.black12,
          child: Align(
            child: Text('通用'),
            alignment: Alignment.centerLeft,
          ),
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return CommonWidget.divider;
              },
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    dataList[index]['tip'],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                );
              }),
        )
      ],
    );
  }


  void _addHint(BuildContext context,int dateIndex,EventBus eventBus) {
   List<String> _tablist = ['日','周','月','年'];

    // 初始化splite函数
    SqlUtil _hintqlite = SqlUtil.setTable('tips');

    // 进来初始化
    String _hint = '';
    final TextEditingController _hintController =
        TextEditingController.fromValue(TextEditingValue(
      text: _hint,
      selection: TextSelection.fromPosition(
        TextPosition(affinity: TextAffinity.downstream, offset: _hint.length),
      ),
    ));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context1, setState) {
            return Container(
              // padding: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14), color: Colors.white),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Text(
                            '取消',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text('新建提示',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),),
                        GestureDetector(
                          child: Text(
                            '存储',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _hint == '' ? Colors.black12 : Colors.black,
                            ),
                          ),
                          onTap: () {
                            eventBus.fire(true);
                            _hintqlite.insert({'date':_tablist[dateIndex],'tip':_hint});
                            Navigator.pop(context,'1211');
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      autofocus: true,
                      controller: _hintController,
                      onChanged: (val){
                        setState((){
                          _hint = val;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入提示',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
