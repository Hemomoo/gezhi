bool dateIsToday(DateTime date) {
  final DateTime now = DateTime.now();
  return date.isAtSameMomentAs(DateTime(now.year, now.month, now.day));
}

int getDaysInMonth(int year, int month) {
  return month < DateTime.monthsPerYear
      ? DateTime(year, month + 1, 0).day
      : DateTime(year + 1, 1, 0).day;
}

String getMonthName(int month, {required List<String> monthNames}) {
  final List<String> names = monthNames.isEmpty
      ? <String>[
        '一月',
        '二月',
        '三月',
        '四月',
        '五月',
        '六月',
        '七月',
        '八月',
        '九月',
        '十月',
        '十一月',
        '十二月',
      ]
      : monthNames;
  return names[month - 1];
}

List<int> getWeekNum(int year, int month) {
  int days = getDaysInMonth(year, month);
  int week = DateTime(year, month, 1).weekday;
  if (days == 31 && (week == 6 || week == 5)) {
    return [1, 2, 3, 4, 5, 6];
  } else if (days == 30 && week == 6) {
    return [1, 2, 3, 4, 5, 6];
  } else if (days == 28 && week == 7) {
    return [1, 2, 3, 4];
  } else {
    return [1, 2, 3, 4, 5];
  }
}
