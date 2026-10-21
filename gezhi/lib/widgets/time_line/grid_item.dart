import 'package:flutter/material.dart';


class GridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
          childAspectRatio: 1.15,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.5, color: Colors.black12),
                  right: BorderSide(
                    width: index % 2 == 0 ? 0.5 : 0,
                    color: Colors.black12,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/time_line/revised_diary',
                arguments: <String, dynamic>{},
              );
            },
          );
        },
      ),
    );
  }
}
