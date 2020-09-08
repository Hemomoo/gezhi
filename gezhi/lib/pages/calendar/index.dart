import 'package:draggable_flutter_list/draggable_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:event_bus/event_bus.dart';

import 'package:gezhi/widgets/calendar/calendar_item.dart';
import 'package:gezhi/widgets/calendar/calendar_list/calendar_list.dart';


import 'package:gezhi/widgets/calendar/calendar_list/utils/chang_year.dart';



class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}


class _CalendarState extends State<Calendar> {
  EventBus eventBus = EventBus(); // 注册eventBus
  String _year = '';

  @override
  void initState() {
    // TODO: implement initState

    eventBus.on<Year>().listen((event) {
      setState(() {
        if(_year != event.year){
          _year = event.year;
        }
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: Icon(
            Icons.replay,
            color: Colors.black,
          ),
        ),
        title: Text(
          '日历',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.sort,
                color: Colors.black,
              ),
            ),
            onTap: () {
              CalendarItem().show(context);
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child:  CalendarList(
              eventBus: eventBus,
              firstDate: DateTime(2000, 1),
              lastDate: DateTime(2100, 8),
              onSelectFinish: (selectStartTime, selectEndTime) {
                List<DateTime> result = <DateTime>[];
                result.add(selectStartTime);
                if (selectEndTime != null) {
                  result.add(selectEndTime);
                }
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(width: 1, color: Colors.black12),
                    ),
                    child: Center(child: Text(_year,style: TextStyle(fontSize: 12),),),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    _year,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



