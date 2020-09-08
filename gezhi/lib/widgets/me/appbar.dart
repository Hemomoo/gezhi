import 'package:flutter/material.dart';

class MeAppbar extends StatelessWidget {
  final String tit ;
  MeAppbar({this.tit = ''});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child:  Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            Text(
              tit,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      onTap: () => {
        Navigator.pop(context),
      },
    );
  }
}
