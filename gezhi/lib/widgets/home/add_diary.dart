//新增日记本
import 'package:flutter/material.dart';
import 'package:gezhi/widgets/home/add_diary_list.dart';

//样式
import 'package:gezhi/style/style.dart';

void addDiary(BuildContext context) {
  int selIndex = -1;
  int step = 1;

  //按钮widget封装
  Widget _stepWidget(selIndex, step) {
    return Container(
      key: UniqueKey(),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selIndex == -1 && step != 3 ? Colors.black12 : Colors.black87,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(step == 1 || step == 2 ? '继续' : '保存', style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(14),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, addDiaryState) {
          return Container(
            padding: EdgeInsets.all(10),
            color: Colors.black12,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      '自定义',
                      style: TextStyle(fontSize: 20.0),
                    )
                  ],
                ),
                Expanded(
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          step == 1 || step == 2
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$step/2'),
                                    Text('你想要通过日记实现'),
                                    Text(
                                      '什么目的',
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                )
                              : Container(),
                          step == 1
                              ? AddDiaryList(UniqueKey(), (index) {
                                  addDiaryState(() {
                                    selIndex = index;
                                  });
                                }, step, selIndex)
                              : step == 2
                                  ? AddDiaryList(UniqueKey(), (index) {
                                      addDiaryState(() {
                                        selIndex = index;
                                      });
                                    }, step, selIndex)
                                  : Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          AnimatedContainer(
                                            height: 200,
                                            width: 150,
                                            alignment: Alignment.center,
                                            duration: Duration(seconds: 3),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage('https://seaside-station.com/wpbin/wp-content/uploads/mori_12.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(
                                                  10,
                                                ))),
                                          )
                                        ],
                                      ),
                                    ),
                          step != 1 && step != 2
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('你完成'),
                                    Text(
                                      '你的日记本已经准备',
                                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '就绪',
                                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              : Container()
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 10,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                addDiaryState(() {
                                  step++;
                                  selIndex = -1;
                                  if (step == 4) Navigator.of(context).pop();
                                });
                              },
                              child: _stepWidget(selIndex, step),
                            ),
                            step != 1 && step != 2
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: GestureDetector(child: Text('日记设置', style: TextStyle(color: GZColors.primary))),
                                  )
                                : Text(''),
                          ],
                        ),
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
