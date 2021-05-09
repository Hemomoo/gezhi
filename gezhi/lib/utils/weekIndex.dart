// // 获取第几周的类
//
class WeekIndex {
  static  DateTime now = DateTime.now(); // 获取当前时间
  static const int EPOCH_WEEK_DAY = 1;
  static final  DateTime epoch = DateTime.utc(now.year);
  static const int EPOCH_MILLIS_SECONDS = 0;
  static const int EPOCH_JULIAN_DAY = 0;

  final int weekStart;

  WeekIndex(this.weekStart);


  static int weekSinceEpoch() {
    now = new DateTime.utc(now.year, now.month, now.day);
    print(EPOCH_WEEK_DAY);
    int offset = EPOCH_WEEK_DAY - 1;
    if (offset < 0) {
      offset += 7;
    }

    int delta = EPOCH_JULIAN_DAY - offset;

    return (now.difference(epoch).inDays - delta) ~/ 7;
  }
}