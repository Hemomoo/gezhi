import 'package:flutter/material.dart';
import 'package:gezhi/fonts/font.dart';
import 'package:gezhi/style/style.dart';

class EditModelLibrary extends StatefulWidget {
  @override
  _EditModelLibraryState createState() => _EditModelLibraryState();
}

class _EditModelLibraryState extends State<EditModelLibrary> {
  List<String> _tipList = [
    '你好啊1',
    '你好啊2',
    '你好啊3',
    '你好啊4',
    '你好啊5',
    '你好啊6',
  ];

  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '新模板',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          PopupMenuButton<String>(
                            offset: Offset(40, 10),
                            padding: EdgeInsets.all(4.0),
                            icon: Icon(Icons.add_circle_outline, size: 30),
                            onSelected: (val) {
                              if (val == 'edit') {
                                _isEdit = true;
                              } else {
                                _tipList.add('新增加的格子');
                              }
                              setState(() {});
                            },
                            itemBuilder: (context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'add',
                                  child: SizedBox(width: 100, child: Row(children: [Icon(Icons.add, size: 26), SizedBox(width: 10), Text('新增格子')])),
                                ),
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: SizedBox(width: 100, child: Row(children: [Icon(Icons.edit), SizedBox(width: 10), Text('编辑格子')])),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                      _iconBar(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: _gridViewWidget(),
                    ),
                  ),
                )
              ],
            ),
            _saveWidget()
          ],
        ),
      ),
    );
  }

//  GridView的item
  List<Widget> _gridViewWidget() {
    List<Widget> _gridWidgetList = [];
    int len = _tipList.length;
    for (int i = 0; i < len; i++) {
      _gridWidgetList.add(
        Container(
          decoration: BoxDecoration(
            border: Border(
              right: (2 * i + 2) % 2 == 0 ? BorderSide(width: 1, color: Color(0xFFF0F2F2)) : BorderSide(width: 0),
              top: BorderSide(width: 1, color: Color(0xFFF0F2F2)),
              bottom: (i == (len - 1) || i == (len - 2)) ? BorderSide(width: 1, color: Color(0xFFF0F2F2)) : BorderSide(width: 0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isEdit
                ? _editWidget(_tipList[i])
                : InkWell(
                    child: Text(_tipList[i], textAlign: TextAlign.center),
                    onTap: () {
                      print('12121');
                    },
                  ),
          ),
        ),
      );
    }
    return _gridWidgetList;
  }

//  修改的widget
  Widget _editWidget(String e) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 26,
              height: 26,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.clear, size: 14),
                  onPressed: () {
                    _tipList.remove(e);
                    setState(() {});
                  }),
            ),
          ),
          Text(e)
        ],
      ),
    );
  }

//  保存的widget
  Widget _saveWidget() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Color(0xFFE7E4E4), offset: Offset(0, 0), blurRadius: 2.0),
            ],
            color: Color(0xFFE7E4E4),
          ),
          height: 40,
          child: Center(
            child: Text(
              '保存',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

//  顶部icon_bar
  Widget _iconBar() {
    if (_isEdit) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
            ],
          ),
          InkWell(
            child: Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
              backgroundColor: GZColors.primary,
              label: Text('完成'),
              labelStyle: TextStyle(color: Colors.white),
            ),
            onTap: () {
              setState(() {
                _isEdit = false;
              });
            },
          ),
        ],
      );
    } else {
      return Row(
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
      );
    }
  }
}
