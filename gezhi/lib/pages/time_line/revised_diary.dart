import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gezhi/style/style.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:quill_delta/quill_delta.dart';
// import 'package:zefyr/zefyr.dart';

class RevisedDiary extends StatefulWidget {
  final Map arguments;
  RevisedDiary({Key? key, this.arguments});

  @override
  _RevisedDiaryState createState() => _RevisedDiaryState();
}

class _RevisedDiaryState extends State<RevisedDiary> {
  bool focus = false;
  // FocusNode _commentFocus = FocusNode();
  int _page = 0;

  PageController _pageController = PageController();

  // final List<Map<String, dynamic>> _contList = [
  //   {'tit': '你好1', 'cont': '你好啊'},
  //   {'tit': '你好2', 'cont': '你好啊'},
  //   {'tit': '你好3', 'cont': '你好啊'},
  //   {'tit': '你好4', 'cont': '你好啊'},
  //   {'tit': '你好5', 'cont': '你好啊'},
  //   {'tit': '你好6', 'cont': '你好啊'},
  // ];
  //
  // // ZefyrController _zefyrController;
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
    // final document = _loadDocument();
    // _controller = ZefyrController(document);
    // _focusNode = FocusNode();

    // _zefyrFocusNode.addListener(() {
    //   // 获取焦点失去焦点
    //   setState(() {
    //     focus = _zefyrFocusNode.hasFocus;
    //   });
    // });
    // // 监听键盘
    // KeyboardVisibility.onChange.listen((bool visible) {
    //   print('121');
    //   setState(() {
    //     focus = visible;
    //   });
    // });
    // //初始化zefyr
    // _loadDocument().then((document) {
    //   setState(() {
    //     _zefyrController = ZefyrController(document);
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          widget.arguments['tit'],
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
            },
            
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
            },
          )
        ],
      ),
      body: Container(
        child: Container(
          child: Stack(
            // children: [
            //   PageView.builder(
            //       onPageChanged: (page) {
            //         setState(() {
            //           _page = page;
            //         });
            //       },
            //       controller: _pageController,
            //       itemCount: _contList.length,
            //       itemBuilder: (context, index) {
            //         return Container(
            //             width: double.infinity,
            //             child: Column(
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //                   child: Align(
            //                     alignment: Alignment.centerLeft,
            //                     child: Text(
            //                       _contList[index]['tit'],
            //                       style: TextStyle(
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Expanded(
            //                   child: (_controller == null)
            //                       ? Center(child: CircularProgressIndicator())
            //                       :
            //                           ZefyrEditor(
            //                             padding: EdgeInsets.symmetric(
            //                               horizontal: 20,
            //                             ),
            //                             controller: _controller,
            //                             focusNode: _focusNode,
            //                             autofocus: false,
            //                         ),
            //                 ),
            //               ],
            //             ));
            //       }),
            //   Positioned(
            //     bottom: focus ? 60.0 : 0.0,
            //     right: 0,
            //     child: Container(
            //       // padding: EdgeInsets.symmetric(horizontal: 10),
            //       width: MediaQuery.of(context).size.width,
            //       child: Column(
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(right: 10, bottom: 10),
            //             child: Align(
            //               alignment: Alignment.bottomRight,
            //               child: GestureDetector(
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(4),
            //                     color: GZColors.primary,
            //                   ),
            //                   padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
            //                   child: Text(
            //                     '完成',
            //                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   // _saveDocument(context);
            //                   Navigator.pop(context);
            //                 },
            //               ),
            //             ),
            //           ),
            //           focus ? Container() : _bottomWidget()
            //         ],
            //       ),
            //     ),
            //   )
            // ],
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
                    IconButton(
                      icon: Icon(Icons.font_download),
                      onPressed: () {
                        // _saveDocument(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.check_circle_outline),
                      onPressed: () {
                        // _saveDocument(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        // getImage();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        // addImage();
                      },
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
