import 'package:flutter/material.dart';

class MeItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String url;
  MeItem({@required this.title, @required this.icon, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            icon,
            size: 24,
            color: Colors.black26,
          ),
        ],
      ),
      onTap: () => {Navigator.of(context).pushNamed(url)},
    );
  }
}
