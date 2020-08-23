import 'package:flutter/material.dart';
import 'dart:ui';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Container(
          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.search,
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  child: TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                      // contentPadding: EdgeInsets.only(top: 0.0),
                      hintText: '搜索日记',
                      border: InputBorder.none,
                    ),
                    // onChanged: onSearchTextChanged,
                  ),
                ),
              ),
              // new IconButton(
              //   icon: new Icon(Icons.cancel),
              //   color: Colors.grey,
              //   iconSize: 18.0,
              //   onPressed: () {
              //     controller.clear();
              //     // onSearchTextChanged('');
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
