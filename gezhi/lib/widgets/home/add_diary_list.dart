import 'package:flutter/material.dart';
//样式
import 'package:gezhi/style/style.dart';

// ignore: must_be_immutable
class AddDiaryList extends StatefulWidget {
  final UniqueKey key;
  final Function selCallBack;
  final int step;
  final int selIndex;

  AddDiaryList(this.key, this.selCallBack, this.step, this.selIndex);

  @override
  _AddDiaryListState createState() => _AddDiaryListState(selCallBack, step, selIndex);
}

class _AddDiaryListState extends State<AddDiaryList> {
  final Function selCallBack;
  final int step; // 步进器
  final int selIndex;

  List<Map> addDiaryList = [];

  _AddDiaryListState(this.selCallBack, this.step, this.selIndex);

  List<Map> oneStepDiaryList = [
    {
      "id": 0,
      "tit": '记录生活',
      "isSel": false,
    },
    {
      "id": 1,
      "tit": '练习关爱自己',
      "isSel": false,
    },
    {
      "id": 2,
      "tit": '养成习惯',
      "isSel": false,
    },
    {
      "id": 3,
      "tit": '实现目标',
      "isSel": false,
    },
    {
      "id": 4,
      "tit": '掌握生活平衡',
      "isSel": false,
    }
  ];

  List<Map> twoStepDiaryList = [
    {
      "id": 0,
      "tit": '偶尔写写',
      "isSel": false,
    },
    {
      "id": 0,
      "tit": '经常写',
      "isSel": false,
    },
    {
      "id": 0,
      "tit": '每日',
      "isSel": false,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    addDiaryList = step == 1 ? oneStepDiaryList : twoStepDiaryList;
    if (selIndex != -1) {
      addDiaryList[selIndex]['isSel'] = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: addDiaryList.map((e) {
          return Container(
            child: InkWell(
              onTap: () {
                int index = addDiaryList.indexOf(e);
                addDiaryList = addDiaryList.map((e) => {'tit': e['tit'], 'id': e['id'], 'isSel': false}).toList();
                addDiaryList[index]['isSel'] = true;
                selCallBack(index);
                setState(() {});
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10),
                  border: e["isSel"] ? Border.all(color: GZColors.primary) : Border.all(color: Color.fromRGBO(255, 0, 0, 0), width: 1),
                ),
                child: Text(
                  e["tit"],
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
