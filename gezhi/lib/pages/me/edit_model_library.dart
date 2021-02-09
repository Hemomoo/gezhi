import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezhi/fonts/font.dart';

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
        child: Column(
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
                      Icon(IconFont.icon_tag, size: 16, color: Colors.black38),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: _tipList
                      .map(
                        (e) => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: (2e+2) % 2 == 0 ? BorderSide(width: 1, color: Color(0xFFF0F2F2)) : BorderSide(width: 0),
                              top: BorderSide(width: 1, color: Color(0xFFF0F2F2)),
                              bottom: (e == _tipList.length - 1 || e == _tipList.length - 2)
                                  ? BorderSide(width: 1, color: Colors.red)
                                  : BorderSide(width: 0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _isEdit
                                ? _editWidget(e)
                                : InkWell(
                                    child: Text(e, textAlign: TextAlign.center),
                                    onTap: () {
                                      print('12121');
                                    },
                                  ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
}
