class Diary {
  late String tip;
  late String date;
  late String diaryInfo;

  Diary({required this.tip, required this.date, required this.diaryInfo});

  Diary.fromJson(Map<String, dynamic> json) {
    tip = json['tip'];
    date = json['date'];
    diaryInfo = json['diaryInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tip'] = this.tip;
    data['date'] = this.date;
    data['diaryInfo'] = this.diaryInfo;
    return data;
  }
}
