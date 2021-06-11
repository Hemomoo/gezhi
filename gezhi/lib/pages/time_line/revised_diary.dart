import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/sqlite/sql_common.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// import 'package:quill_delta/quill_delta.dart';
// import 'package:zefyr/zefyr.dart';

class RevisedDiary extends StatefulWidget {
  final Map arguments;
  RevisedDiary({Key key, this.arguments});

  @override
  _RevisedDiaryState createState() => _RevisedDiaryState();
}

class _RevisedDiaryState extends State<RevisedDiary> {
  bool focus = false;
  FocusNode _commentFocus = FocusNode();
  int _page = 0;

  final SqlUtil hintSql = SqlUtil.setTable('tips');
  final SqlUtil diarySql = SqlUtil.setTable('diary');
  PageController _pageController;

  List<Map<String, dynamic>> _contList = [];
  List<TextEditingController> _textEditingControllerList = [];
  String dateTit;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextEditingController _diaryController = TextEditingController();

  // ZefyrController _zefyrController;
  // FocusNode _focusNode;
  // ZefyrController _controller;

  // FocusNode _zefyrFocusNode = FocusNode();

  /// Loads the document asynchronously from a file if it exists, otherwise
  /// returns default document.
  // Future<NotusDocument> _loadDocument() async {
  //   final file = File(Directory.systemTemp.path + '/quick_start.json');
  //   if (await file.exists()) {
  //     final contents = await file.readAsString().then((data) => Future.delayed(Duration(seconds: 1), () => data));
  //     return NotusDocument.fromJson(jsonDecode(contents));
  //   }
  //   final delta = Delta()..insert('\n');
  //   return NotusDocument.fromDelta(delta);
  // }

  // void _saveDocument(BuildContext context) {
  //   // Notus documents can be easily serialized to JSON by passing to
  //   // `jsonEncode` directly:
  //   final contents = jsonEncode(_zefyrController.document);
  //   // For this example we save our document to a temporary file.
  //   final file = File(Directory.systemTemp.path + '/quick_start.json');
  //   // And show a snack bar on success.
  //   file.writeAsString(contents).then((_) {
  //     Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saved.')));
  //   });
  // }

  // NotusDocument _loadDocument() {
  //   // For simplicity we hardcode a simple document with one line of text
  //   // saying "Zefyr Quick Start".
  //   // (Note that delta must always end with newline.)
  //   final Delta delta = Delta()..insert("Zefyr Quick Start\n");
  //   return NotusDocument.fromDelta(delta);
  // }

  @override
  void initState() {
    final int index = widget.arguments['index'];

    // 查询前7条数据
    hintSql.limitQuery('tips', 7).then((value) {
      //循环变量生成文本controller
      _contList = value;
      diarySql.query(conditions: {"tip": "${value[index]['tip']}", "date": "${widget.arguments['date']}"}).then((value) {
        for (int i = 0; i < _contList.length; i++) {
          if (widget.arguments['index'] == i && value.length != 0) {
            _textEditingControllerList.add(TextEditingController(text: value[0]['diaryInfo']));
          } else {
            _textEditingControllerList.add(TextEditingController());
          }
        }
        setState(() {});
      });
    });

    _pageController = PageController(initialPage: widget.arguments['index']);

    // List<String> dateList = widget.arguments['date'].split('-');
    // dateTit = '${dateList.first}年${dateList[1]}月${dateList.last}日';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.arguments['date'],
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.remove_red_eye),
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
          )
        ],
      ),
      body: Container(
        child: Container(
          child: Stack(
            children: [
              _textEditingControllerList.length != 0
                  ? PageView.builder(
                      onPageChanged: (page) {
                        setState(() {
                          _page = page;
                          diarySql.query(conditions: {"tip": "${_contList[page]['tip']}", "date": "${widget.arguments['date']}"}).then((value) {
                            if (value.length != 0) {
                              _textEditingControllerList[page].text = value[0]['diaryInfo'];
                            }
                          });
                        });
                      },
                      controller: _pageController,
                      itemCount: _contList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _contList[index]['tip'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _textEditingControllerList[index],
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 30,
                                    // expands: true,
                                    decoration: InputDecoration(),
                                  ),
                                ),
                              ],
                            ));
                      })
                  : Container(),
              Positioned(
                bottom: focus ? 60.0 : 0.0,
                right: 0,
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10, bottom: 10),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: GZColors.primary,
                              ),
                              padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: Text(
                                '完成',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            onTap: () {
                              diarySql.query(conditions: {"tip": "${_contList[_page]['tip']}", "date": "${widget.arguments['date']}"}).then((value) {
                                if (value.length == 0) {
                                  diarySql.insert({
                                    'tip': _contList[_page]['tip'],
                                    'date': widget.arguments['date'],
                                    'diaryInfo': _textEditingControllerList[_page].text
                                  }).then((value) {
                                    Navigator.pop(context, '日记填写完成');
                                  });
                                } else {
                                  diarySql
                                      .update({'diaryInfo': _textEditingControllerList[_page].text}, 'tip', _contList[_page]['tip']).then((value) {
                                    print(value);
                                    Navigator.pop(context, '日记填写完成');
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      focus ? Container() : _bottomWidget()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomWidget() {
    return Container(
      color: focus ? Colors.black12 : Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          focus
              ? Row(
                  children: [
                    IconButton(icon: Icon(Icons.font_download)),
                    IconButton(
                      icon: Icon(Icons.check_circle_outline),
                    ),
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        // getImage();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                    )
                  ],
                )
              : Container(),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: _page == 0 ? Colors.black12 : Colors.black,
                ),
                onPressed: () {
                  if (_page > 0) {
                    setState(() {
                      _page = _page - 1;
                      _pageController.jumpToPage(_page);
                    });
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_page < 5) {
                    setState(() {
                      _page = _page + 1;
                      _pageController.jumpToPage(_page);
                    });
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    focus = !focus;
                    if (!focus) {
                      // _zefyrFocusNode.unfocus();
                    } else {
                      // FocusScope.of(context).requestFocus(_zefyrFocusNode);
                    }
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
