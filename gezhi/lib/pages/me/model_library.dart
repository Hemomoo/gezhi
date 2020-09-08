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
        child: GridView(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
                children: [],
        ),
      ),
    );
  }

// 模板
  Widget _template() {
    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int) {
            return Text('121');
          }),
    );
  }
}
