import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gezhi/style/style.dart';

class CalendarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
            ),
            width: MediaQuery.of(context).size.width * 0.1,
            child: SizedBox(
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, int) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          '31',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 30,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
//                  mainAxisSpacing: 10,
//                  crossAxisSpacing: 10,
//                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: GZColors.primary,
                      ),
                      child: Center(child: Text('1')),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void show(context) {
    // showDatePicker(
    //   context: context,
    //   initialDate: DateTime(2020),
    //   firstDate: DateTime(1998),
    //   lastDate: DateTime(2029),
    // );
  }
}
