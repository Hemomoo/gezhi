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
            onPressed: () {
              //  跳转到修改页面
              Navigator.pushNamed(context, '/me/edit_model_library');
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          children: [1, 2, 3, 4, 5, 6, 7, 8, 10]
              .map(
                (e) => Column(
                  children: [
                    InkWell(
                      child: _template(),
                      onLongPress: () {
                        print('121');
                      },
                    ),
                    Text('默认模板')
                  ],
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
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8, //阴影模糊程度
              spreadRadius: 4 //阴影扩散程度
              )
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        physics: new NeverScrollableScrollPhysics(), // 禁止滚动
        itemCount: 4,
        itemBuilder: (BuildContext context, int) {
          return Text('121');
        },
      ),
    );
  }
}
