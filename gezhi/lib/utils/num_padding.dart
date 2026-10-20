// 主要用于给日期月份和日补零

String numPadding(num) {
  if (num is String) {
    return int.parse(num) < 10 ? '0$num' : num;
  }
  if (num is int) {
    return num < 10 ? '0$num' : '$num';
  }
  return '';
}
