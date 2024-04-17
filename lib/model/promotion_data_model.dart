class GetAllPromotionModel {
  String? status;
  String? success;
  String? message;
  List<GetAllPromotionModelData>? data;

  GetAllPromotionModel({this.status, this.success, this.message, this.data});

  GetAllPromotionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllPromotionModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetAllPromotionModelData.fromJson(v));
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

class GetAllPromotionModelData {
  String? sId;
  String? mainTitle;
  String? subTitle;
  String? promotionCode;
  String? discription;
  String? promotionDate;
  String? otherComments;
  int? iV;

  GetAllPromotionModelData(
      {this.sId,
      this.mainTitle,
      this.subTitle,
      this.promotionCode,
      this.discription,
      this.promotionDate,
      this.otherComments,
      this.iV});

  GetAllPromotionModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mainTitle = json['main_title'];
    subTitle = json['sub_title'];
    promotionCode = json['promotion_code'];
    discription = json['discription'];
    promotionDate = json['promotion_date'];
    otherComments = json['other_comments'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['main_title'] = this.mainTitle;
    data['sub_title'] = this.subTitle;
    data['promotion_code'] = this.promotionCode;
    data['discription'] = this.discription;
    data['promotion_date'] = this.promotionDate;
    data['other_comments'] = this.otherComments;
    data['__v'] = this.iV;
    return data;
  }
}
