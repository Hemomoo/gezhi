import 'package:flutter/material.dart';

class MeItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String url;
  final bool isRefresh;
  MeItem({@required this.title, @required this.icon, this.url,this.isRefresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
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
              ),
            ),
          ],
        ),
      ),
      onTap: () => {
        Navigator.of(context).pushNamed(url)
      },
    );
  }
}
