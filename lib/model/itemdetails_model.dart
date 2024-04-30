class AllProductDetailsModel {
  String? status;
  String? success;
  String? message;
  List<AllProductDetailsModelData>? data;

  AllProductDetailsModel({this.status, this.success, this.message, this.data});

  AllProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllProductDetailsModelData>[];
      json['data'].forEach((v) {
        data!.add(new AllProductDetailsModelData.fromJson(v));
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

class AllProductDetailsModelData {
  String? sId;
  String? companyName;
  String? itemname;
  String? itemcode;
  String? itemdescription;
  String? quantity;
  String? unitprice;
  String? manifectdate;
  String? expdate;
  bool? discountAvailable;
  String? discountrate;
  String? discountprice;
  String? newMarketPrice;
  String? dicountIssuDate;
  String? dicountExpiredDate;
  String? imageUrl;
  int? iV;

  AllProductDetailsModelData(
      {this.sId,
      this.companyName,
      this.itemname,
      this.itemcode,
      this.itemdescription,
      this.quantity,
      this.unitprice,
      this.manifectdate,
      this.expdate,
      this.discountAvailable,
      this.discountrate,
      this.discountprice,
      this.newMarketPrice,
      this.dicountIssuDate,
      this.dicountExpiredDate,
      this.imageUrl,
      this.iV});

  AllProductDetailsModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    companyName = json['company_name'];
    itemname = json['itemname'];
    itemcode = json['itemcode'];
    itemdescription = json['itemdescription'];
    quantity = json['quantity'];
    unitprice = json['unitprice'];
    manifectdate = json['manifectdate'];
    expdate = json['expdate'];
    discountAvailable = json['discount_available'];
    discountrate = json['discountrate'];
    discountprice = json['discountprice'];
    newMarketPrice = json['new_market_price'];
    dicountIssuDate = json['dicount_issu_date'];
    dicountExpiredDate = json['dicount_expired_date'];
    imageUrl = json['image_url'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['company_name'] = this.companyName;
    data['itemname'] = this.itemname;
    data['itemcode'] = this.itemcode;
    data['itemdescription'] = this.itemdescription;
    data['quantity'] = this.quantity;
    data['unitprice'] = this.unitprice;
    data['manifectdate'] = this.manifectdate;
    data['expdate'] = this.expdate;
    data['discount_available'] = this.discountAvailable;
    data['discountrate'] = this.discountrate;
    data['discountprice'] = this.discountprice;
    data['new_market_price'] = this.newMarketPrice;
    data['dicount_issu_date'] = this.dicountIssuDate;
    data['dicount_expired_date'] = this.dicountExpiredDate;
    data['image_url'] = this.imageUrl;
    data['__v'] = this.iV;
    return data;
  }
}
