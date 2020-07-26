class WeekDayModel {
  String week;
  int day;

  WeekDayModel({this.week, this.day});

  WeekDayModel.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    day = json['day'];
  }

  Map<String, Object> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week'] = this.week;
    data['day'] = this.day;
    return data;
  }
}
