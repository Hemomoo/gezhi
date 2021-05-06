import 'package:flutter/material.dart';
//样式
import 'package:gezhi/style/style.dart';

// ignore: must_be_immutable
class AddDiaryList extends StatefulWidget {
  List<Map> addDiaryList;
  final UniqueKey key;
  final Function selCallBack;
  final int step;

  AddDiaryList(
    this.addDiaryList,
    this.key,
    this.selCallBack,
    this.step,
  );

  @override
  _AddDiaryListState createState() => _AddDiaryListState(addDiaryList, selCallBack, step);
}

class _AddDiaryListState extends State<AddDiaryList> {
  List<Map> addDiaryList;
  final Function selCallBack;
  final step; // 步进器

  _AddDiaryListState(this.addDiaryList, this.selCallBack, this.step);

  @override
  void initState() {
    // TODO: implement initState
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
