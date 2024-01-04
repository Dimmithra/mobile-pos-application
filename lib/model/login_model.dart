class LoginModal {
  String? status;
  String? success;
  String? message;
  String? token;
  User? user;

  LoginModal({this.status, this.success, this.message, this.token, this.user});

  LoginModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? email;
  String? customername;
  String? mobileno;

  User({this.email, this.customername, this.mobileno});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    customername = json['customername'];
    mobileno = json['mobileno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['customername'] = this.customername;
    data['mobileno'] = this.mobileno;
    return data;
  }
}
