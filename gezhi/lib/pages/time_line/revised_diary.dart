import 'package:flutter/material.dart';






class RevisedDiary extends StatefulWidget {
  final Map arguments;
  RevisedDiary({Key key, this.arguments});

  @override
  _RevisedDiaryState createState() => _RevisedDiaryState();
}

class _RevisedDiaryState extends State<RevisedDiary> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){

          },
        ),
        title: Text(widget.arguments['tit']) ,
        actions: [
          IconButton(
            icon: Icon(Icons.remove_red_eye),
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
          )
        ],
      ),
      body: Container(
        child: Hero(
          tag: '${widget.arguments['index']}revisedDiary',
          child: Container(
            child: Text('${widget.arguments['index']}'),
          ),
        ),
      ),
    );
  }
}
