class BillRecordsModel {
  String? status;
  String? success;
  String? message;
  List<Data>? data;

  BillRecordsModel({this.status, this.success, this.message, this.data});

  BillRecordsModel.fromJson(Map<String, dynamic> json) {
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
  String? cusEmail;
  String? cusMobileno;
  String? cusName;
  String? dateTime;
  String? itemcount;
  List<Item>? item;
  String? totalAmount;
  String? tdiscountAmount;
  String? subtotal;
  String? billNo;
  int? iV;

  Data(
      {this.sId,
      this.cusEmail,
      this.cusMobileno,
      this.cusName,
      this.dateTime,
      this.itemcount,
      this.item,
      this.totalAmount,
      this.tdiscountAmount,
      this.subtotal,
      this.billNo,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cusEmail = json['cus_email'];
    cusMobileno = json['cus_mobileno'];
    cusName = json['cus_name'];
    dateTime = json['date_time'];
    itemcount = json['itemcount'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    tdiscountAmount = json['tdiscount_amount'];
    subtotal = json['subtotal'];
    billNo = json['bill_no'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cus_email'] = this.cusEmail;
    data['cus_mobileno'] = this.cusMobileno;
    data['cus_name'] = this.cusName;
    data['date_time'] = this.dateTime;
    data['itemcount'] = this.itemcount;
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['tdiscount_amount'] = this.tdiscountAmount;
    data['subtotal'] = this.subtotal;
    data['bill_no'] = this.billNo;
    data['__v'] = this.iV;
    return data;
  }
}

class Item {
  String? itemcode;
  String? name;
  String? qty;
  String? amount;
  String? discountPrice;
  String? itemTotal;
  String? sId;

  Item(
      {this.itemcode,
      this.name,
      this.qty,
      this.amount,
      this.discountPrice,
      this.itemTotal,
      this.sId});

  Item.fromJson(Map<String, dynamic> json) {
    itemcode = json['itemcode'];
    name = json['name'];
    qty = json['qty'];
    amount = json['amount'];
    discountPrice = json['discount_price'];
    itemTotal = json['itemTotal'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemcode'] = this.itemcode;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['amount'] = this.amount;
    data['discount_price'] = this.discountPrice;
    data['itemTotal'] = this.itemTotal;
    data['_id'] = this.sId;
    return data;
  }
}
