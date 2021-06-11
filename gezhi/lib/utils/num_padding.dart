// 主要用于给日期月份和日补零

String numPadding(num) {
  String number;
  if (num is String) {
    number = int.parse(num) < 10 ? '0$num' : num;
  }
  if (num is int) {
    number = num < 10 ? '0$num' : '$num';
  }

  return number;
}
