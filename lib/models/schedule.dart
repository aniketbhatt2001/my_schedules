class ScheduleModel {
  String? id;
  String? date;
  String? time;
  String? docName;
  String? onlineMeeting;
  String? emailCc;

  ScheduleModel(
      {this.id,
      this.date,
      this.time,
      this.docName,
      this.onlineMeeting,
      this.emailCc});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    docName = json['doc_name'];
    onlineMeeting = json['online_meeting'];
    emailCc = json['email_cc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['doc_name'] = this.docName;
    data['online_meeting'] = this.onlineMeeting;
    data['email_cc'] = this.emailCc;
    return data;
  }
}
