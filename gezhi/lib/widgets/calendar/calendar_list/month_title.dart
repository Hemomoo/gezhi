import 'package:flutter/material.dart';

import 'utils/dates.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    required this.month,
    this.color = Colors.black,
    this.monthNames = const [],
  });

  final Color color;
  final int month;
  final List<String> monthNames;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),

      child: Text(
        getMonthName(month, monthNames: monthNames),
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }
}
