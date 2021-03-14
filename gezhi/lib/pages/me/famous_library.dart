import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezhi/fonts/font.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/me/appbar.dart';
import 'package:gezhi/widgets/common/common.dart';
// import 'package:gezhi/sqlite/famous_db.dart';

import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:gezhi/sqlite/sql_common.dart';


class FamousLibrary extends StatefulWidget {
  @override
  _FamousLibraryState createState() => _FamousLibraryState();
}

class _FamousLibraryState extends State<FamousLibrary> {
  final SqlUtil tipSqlite = SqlUtil.setTable('famous');
  List famousList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // print( ModalRoute.of(context).settings.arguments);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: MeAppbar(
          url: '/home',
        ),
        title: Text(
          '名言库',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                _popupItem(
                  'addFamous',
                  Icons.add_to_photos,
                  '新增名言',
                ),
                _popupItem(
                  'editFamous',
                  IconFont.icon_gaixie,
                  '管理名言',
                )
              ];
            },
            onSelected: (val) {
              if (val == 'addFamous') {
                _addFamous(context);
              }
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: (() async {
          return await tipSqlite.get();
        })(),
        builder: (BuildContext context, snap) {
          if (snap.hasData) {
            famousList =  List.from(snap.data) ;
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border(
                      left: BorderSide(width: 4, color: GZColors.primary),
                    ),
                  ),
                  child: Padding(
                    child: Text('默认'),
                    padding: EdgeInsets.only(left: 10),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: famousList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          famousList[index]['sentence'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(famousList[index]['author']),
                        onTap: () {
                          _famousHandle(
                              context,
                              famousList[index]['sentence'],
                              famousList[index]['id'],
                              famousList[index]['author']);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return CommonWidget.divider;
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  PopupMenuEntry<String> _popupItem(
    String val,
    IconData popIcon,
    String tit,
  ) {
    return PopupMenuItem<String>(
      value: 'addFamous',
      child: Chip(
        label: Text(
          tit,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        avatar: Icon(
          popIcon,
          color: GZColors.primary,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  void _famousHandle(BuildContext context,  String tit,int id, String author) {
    showModalBottomSheet(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 240,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  tit,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.edit,
                  color: Colors.black26,
                ),
                title: Text(
                  '编辑名言',
                  style: TextStyle(color: Colors.black26),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: GZColors.primary,
                ),
                title: Text('删除文本'),
                onTap: () async {
                  famousList.removeAt(famousList.indexWhere((element) => element['id'] == id));
                  await tipSqlite.delete("id", id);
                  setState(() {}); // future 会重绘
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.content_paste,
                  color: GZColors.primary,
                ),
                title: Text('拷贝文本'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: tit)).then(
                    (value) => {
                      Toast.show("复制成功", context),
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 增加名言
  void _addFamous(BuildContext context) {
    String _famous = '';
    String _author = '';
    final TextEditingController _famousController =
        TextEditingController.fromValue(TextEditingValue(
      text: _famous,
      selection: TextSelection.fromPosition(
        TextPosition(affinity: TextAffinity.downstream, offset: _famous.length),
      ),
    )); // 表示初始化的复制,不需要复制的时候可以直接定义一个变量
    final TextEditingController _authorController =
        TextEditingController.fromValue(
      TextEditingValue(
        text: _author,
        selection: TextSelection.fromPosition(
          TextPosition(
              affinity: TextAffinity.downstream, offset: _author.length),
        ),
      ),
    );
    SqlUtil tipSqlite = SqlUtil.setTable('famous');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context1, state) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.black12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Text(
                            '取消',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.of(context).pop(false);
                          },
                        ),
                        Center(
                          child: Text(
                            '新建名言',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            '存储',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: _famous != '' || _author != ''
                                  ? Colors.black
                                  : Colors.black12,
                            ),
                          ),
                          onTap: () async {
                            if (_author != '' || _famous != '') {

                              await tipSqlite
                                  .insert({'id': null,'sentence':_famous,'author':_author});
                              Navigator.pushReplacementNamed(context, '/me/famous_library',); // 跳转关闭当前页面
                              // Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          controller: _authorController,
                          decoration: InputDecoration(
                            hintText: '''作者 （可选）''',
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            state(() {
                              _author = val;
                            });
                          },
                        ),
                        TextField(
                          autofocus: true,
                          maxLines: 4,
                          controller: _famousController,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            isDense: true, // 多行
                            hintText: '名言',
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          onChanged: (val) async {
                            state(() {
                              _famous = val;
                            });
                          },
                        ),
                      ],
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
