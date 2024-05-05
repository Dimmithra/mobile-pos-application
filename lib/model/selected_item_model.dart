class SelectedProductDetailsModelData {
  String? itemName;
  String? qty;
  String? price;
  String? discount;
  String? no;
  String? totelPrice;
  SelectedProductDetailsModelData({
    this.itemName,
    this.qty,
    this.price,
    this.discount,
    this.no,
    this.totelPrice,
  });
  SelectedProductDetailsModelData.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
    no = json['no'];
    totelPrice = json['totelPrice'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['no'] = this.no;
    data['totelPrice'] = this.totelPrice;
    return data;
  }
}
