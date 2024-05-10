class GetAllMessageResponse {
  String? status;
  String? success;
  String? message;
  List<Data>? data;

  GetAllMessageResponse({this.status, this.success, this.message, this.data});

  GetAllMessageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  List<Messages>? messages;
  int? iV;

  Data({this.sId, this.messages, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Messages {
  String? cusemail;
  String? cusname;
  String? message;
  String? date;
  String? time;
  String? sId;

  Messages(
      {this.cusemail,
      this.cusname,
      this.message,
      this.date,
      this.time,
      this.sId});

  Messages.fromJson(Map<String, dynamic> json) {
    cusemail = json['cusemail'];
    cusname = json['cusname'];
    message = json['message'];
    date = json['date'];
    time = json['time'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cusemail'] = this.cusemail;
    data['cusname'] = this.cusname;
    data['message'] = this.message;
    data['date'] = this.date;
    data['time'] = this.time;
    data['_id'] = this.sId;
    return data;
  }
}
