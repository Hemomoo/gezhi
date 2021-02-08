import 'package:flutter/material.dart';

class ModelLibrary extends StatefulWidget {
  @override
  _ModelLibraryState createState() => _ModelLibraryState();
}

class _ModelLibraryState extends State<ModelLibrary> {
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
        actionsIconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '模板',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 28,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 30, crossAxisSpacing: 20, childAspectRatio: 0.8),
          children: [1, 2, 3, 4, 5, 6, 7, 8, 10]
              .map(
                (e) => InkWell(
                  child: _template(),
                  onLongPress: () {
                    print('121');
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

// 模板
  Widget _template() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10, //阴影模糊程度
              spreadRadius: 2 //阴影扩散程度
              )
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        physics: new NeverScrollableScrollPhysics(), // 禁止滚动
        itemCount: 4,
        itemBuilder: (BuildContext context, int) {
          return Text('121');
        },
      ),
    );
  }

  // void _editModel() {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //     context: context,
  //     isScrollControlled: false,
  //     enableDrag: false,
  //     elevation: 120, // 高度
  //     builder: (BuildContext context) {
  //       return Container();
  //     },
  //   );
  // }
}
