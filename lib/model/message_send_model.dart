class MessageSendModel {
  String? name;
  String? date;
  String? time;
  String? email;
  String? message;

  MessageSendModel({
    this.name,
    this.date,
    this.time,
    this.email,
    this.message,
  });
  MessageSendModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    time = json['time'];
    email = json['email'];
    message = json['message'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['time'] = this.time;
    data['email'] = this.email;
    data['message'] = this.message;
    return data;
  }
}
