import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:gezhi/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BatchExport extends StatefulWidget {
  @override
  _BatchExportState createState() => _BatchExportState();
}

class _BatchExportState extends State<BatchExport> {
  bool _isInclude = false;
  late String _exportModeVal;
  late int selVal;
  late SharedPreferences prefs;
  List<Map> _modeList = [
    {'val': 0, 'tit': '纯文本'},
    {'val': 1, 'tit': 'Markdown'},
    {'val': 2, 'tit': 'PDF'},
    {'val': 3, 'tit': '印象笔记'}
  ];

  @override
  void initState() {
    // TODO: implement initState
    // 延时1s执行返回
    Future.delayed(Duration(seconds: 0), () async {
      prefs = await SharedPreferences.getInstance();
      selVal = prefs.getInt('selExportType') ?? 0;
      _exportModeVal = _modeList[selVal]['tit'];
      setState(() {});
    });

    super.initState();
  }

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
                leading: Text(_exportModeVal ?? ''),
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
            _trendsWidget(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                // color: GZColors.primary,
                // minWidth: MediaQuery.of(context).size.width - 36,
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

  Widget _batchExportItem({required String tit, Widget? leading, Function? fn}) {
    return ListTile(
      title: Text(
        tit,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      trailing: Container(
        width: 160,
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
        fn?.call(); 
      },
    );
  }

//  选择导出格式
  void _exportMode() async {
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
                                // 存入缓存
                                prefs.setInt('selExportType', item['val']);
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

//  根据不同的值生产不同的 Widget
  Widget _trendsWidget() {
    //是不是授权
    bool isAuthorization = false;
    switch (selVal) {
      case 2:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Container(
                height: 30,
                child: Center(
                  child: _batchExportItem(
                    tit: 'PDF尺寸',
                    leading: Text('A4'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Container(
                height: 30,
                child: Center(
                  child: _batchExportItem(
                    tit: 'PDF文件选项',
                    leading: Text('合并成一个文件'),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case 3:
        {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Container(
                  height: 30,
                  child: _batchExportItem(
                    tit: '印象笔记用户',
                    leading: Text(
                      '授权',
                      style: TextStyle(color: GZColors.primary),
                    ),
                    fn: _authEvernotr,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Container(
                  height: 30,
                  child: _batchExportItem(
                    tit: '覆盖已经已有标签',
                    leading: CupertinoSwitch(
                      value: false,
                      onChanged: (val) {
                        print(val);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Container(
                  height: 30,
                  child: _batchExportItem(
                    tit: '包含标签',
                    leading: CupertinoSwitch(
                      value: false,
                      onChanged: (val) {
                        print(val);
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        }
        break;
      default:
        {
          return _batchExportItem(
            tit: '包括附件',
            leading: CupertinoSwitch(
              value: _isInclude,
              onChanged: (val) {
                setState(() {
                  _isInclude = val;
                });
              },
            ),
          );
        }
        break;
    }
  }

//  授权webView
  void _authEvernotr() {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.146 Safari/537.36')
      ..loadRequest(Uri.parse('https://griddiaryapp.com/zh/'));
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      context: context,
      isScrollControlled: false,
      enableDrag: false,
      elevation: 120, // 高度
      builder: (BuildContext context) {
        return Container(
          child: WebViewWidget(controller: controller),
        );
      },
    );
  }
}
