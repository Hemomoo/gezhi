import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gezhi/style/style.dart';

class BatchExport extends StatefulWidget {
  @override
  _BatchExportState createState() => _BatchExportState();
}

class _BatchExportState extends State<BatchExport> {
  bool _isInclude = false;
  String _exportModeVal = 'Markdown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          '批量导出',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: _batchExportItem(tit: '日记', leading: Text('700')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: _batchExportItem(
                tit: '格式',
                leading: Text(_exportModeVal),
                fn: _exportMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '设置',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black26),
                ),
              ),
            ),
            _batchExportItem(
              tit: '包括附件',
              leading: CupertinoSwitch(
                value: _isInclude,
                onChanged: (val) {
                  setState(() {
                    _isInclude = val;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FlatButton(
                color: GZColors.primary,
                minWidth: MediaQuery.of(context).size.width - 36,
                child: Text(
                  '导出',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _batchExportItem({@required String tit, Widget leading, Function fn}) {
    return ListTile(
      title: Text(
        tit,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            leading == null ? Text('') : leading,
            SizedBox(
              width: (leading is! CupertinoSwitch) ? 10 : 0,
            ),
            (leading is! CupertinoSwitch)
                ? Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  )
                : SizedBox(
                    width: 0,
                  ),
          ],
        ),
      ),
      onTap: () {
        fn();
      },
    );
  }

//  选择导出格式
  void _exportMode() {
    int selVal = 1;
    List<Map> _modeList = [
      {'val': 1, 'tit': '纯文本'},
      {'val': 2, 'tit': 'Markdown'},
      {'val': 3, 'tit': 'PDF'},
      {'val': 4, 'tit': '印象笔记'}
    ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      builder: (BuildContext context) {
        return Container(
          child: StatefulBuilder(
            builder: (BuildContext context, setBottomSheetState) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text('格式'),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: _modeList.map((item) {
                          return Container(
                            // padding: EdgeInsets.all(10),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      item['tit'],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  selVal == item['val']
                                      ? Icon(
                                          Icons.done,
                                          color: GZColors.primary,
                                        )
                                      : Text('')
                                ],
                              ),
                              onTap: () {
                                setBottomSheetState(() {
                                  selVal = item['val'];
                                });
                                setState(() {
                                  this._exportModeVal = item['tit'];
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
