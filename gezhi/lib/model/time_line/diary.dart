class Diary {
  String tip;
  String date;
  String diaryInfo;

  Diary({this.tip, this.date, this.diaryInfo});

  Diary.fromJson(Map<String, dynamic> json) {
    tip = json['tip'];
    date = json['date'];
    diaryInfo = json['diaryInfo'];
  }

  Map<String, Object> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tip'] = this.tip;
    data['date'] = this.date;
    data['diaryInfo'] = this.diaryInfo;
    return data;
  }
}
