import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:mobile_pos/model/itemdetails_model.dart';
import 'package:mobile_pos/model/selected_item_model.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:mobile_pos/utils/url.dart';

class ProductDetailsProvider extends ChangeNotifier {
  bool loadingProductData = false;
  bool get getloadingProductData => loadingProductData;
  setloadingProductData(Val) {
    loadingProductData = Val;
    notifyListeners();
  }

  Future<void> getAllProduct(context) async {
    try {
      setloadingProductData(true);
      var reqBody = {};
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kgetAllItemRecord),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      dev.log(response.body);

      AllProductDetailsModel temp =
          AllProductDetailsModel.fromJson(jsonDecode(response.body));
      dev.log(response.body);

      if (temp.success == 'success') {
        setallProductDetailsModelData(temp);
      } else {
        setallProductDetailsModelData(temp);
        commonMessage(context, errorTxt: "No Promotion Founded").show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadingProductData(false);
    }
  }

  AllProductDetailsModel? allProductDetailsModelData;
  AllProductDetailsModel? get getallProductDetailsModelData =>
      allProductDetailsModelData;
  setallProductDetailsModelData(val) {
    allProductDetailsModelData = val;
    notifyListeners();
  }

  AllProductDetailsModelData? allProductDetailsModelDataList;
  AllProductDetailsModelData? get getallProductDetailsModelDataList =>
      allProductDetailsModelDataList;
  setallProductDetailsModelDataList(val) {
    allProductDetailsModelDataList = val;
    notifyListeners();
  }

  TextEditingController searchItemController = TextEditingController();
  TextEditingController get getsearchItemController => searchItemController;

  // List<String> get getAllProductDetailList {
  //   List<String> temp = [];
  //   if (getallProductDetailsModelData!.data != null) {
  //     for (var i = 0; i < getallProductDetailsModelData!.data!.length; i++) {
  //       temp.add(getallProductDetailsModelData!.data![i].itemname!);
  //     }
  //   }

  //   return temp;
  // }

  List<DropdownMenuItem<dynamic>>? get getAllProductDetailList {
    List<DropdownMenuItem<dynamic>>? temp = [];
    for (var i = 0; i < getallProductDetailsModelData!.data!.length; i++) {
      temp.add(DropdownMenuItem(
        value: getallProductDetailsModelData!.data![i],
        child: Text(
          "${getallProductDetailsModelData!.data![i].companyName!} (${getallProductDetailsModelData!.data![i].itemname}- Rs.${getallProductDetailsModelData!.data![i].newMarketPrice!.isNotEmpty ? getallProductDetailsModelData!.data![i].newMarketPrice : getallProductDetailsModelData!.data![i].unitprice} )",
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ));
    }

    return temp;
  }

  List<SelectedProductDetailsModelData> selectedProductDetailsModelData = [];
  List<SelectedProductDetailsModelData>
      get getselectedProductDetailsModelData => selectedProductDetailsModelData;
  addSelectedProductDetailsModelData(
    context, {
    String? itemCode,
    String? itemName,
    String? price,
    String? qty,
    String? discount,
    String? totelPrice,
  }) {
    var temp = SelectedProductDetailsModelData(
        itemName: itemName,
        no: itemCode,
        price: price,
        qty: qty.toString(),
        discount: discount,
        totelPrice: totelPrice);
    addItemRecords(temp);
    // }
  }

  addItemRecords(val) {
    getselectedProductDetailsModelData.add(val);
    notifyListeners();
  }

  removeaddItemRecords(SelectedProductDetailsModelData val) {
    getselectedProductDetailsModelData.remove(val);
    notifyListeners();
  }

  updateQtyForItem(String itemCode, String newQty) {
    // Find the index of the item with the given itemCode
    int index = getselectedProductDetailsModelData
        .indexWhere((item) => item.no == itemCode);

    if (index != -1) {
      // Update the quantity of the item at the found index
      getselectedProductDetailsModelData[index].qty = newQty;
      notifyListeners();
    } else {
      // Item with the given itemCode not found
      print('Item with itemCode $itemCode not found.');
    }
  }
  //Bill Amount calculation

  // double qty = 0;
  // // double get _qty => qty;
  // void incrementQty() {
  //   qty++;
  //   notifyListeners();
  // }

  // void decrementQty(context) {
  //   if (qty <= 1) {
  //     // commonMessage(context, errorTxt: "Cannot enter - values").show();
  //   } else {
  //     qty--;
  //   }
  //   notifyListeners();
  // }

  // String itemTotalAmount = "";
  // String totalBillAmount = "";

  // void calculatePriceDetails(
  //   context, {
  //   String? itmprice,
  //   String? quntityIncrese,
  // }) async {
  //   double? qtyIncrese = double.parse(quntityIncrese!);
  //   // if (qtyMinues <= 1) {
  //   //   // commonMessage(context, errorTxt: "Cannot enter - values").show();
  //   // } else {
  //   qty = qtyIncrese;

  //   qty++;
  //   notifyListeners();
  //   double selectItmeprice = double.tryParse(itmprice.toString()) ?? 0;
  //   // totalBillAmount = selectItmeprice;
  //   double itemTotal = qty * selectItmeprice;
  //   totalBillAmount = itemTotal.toString();
  //   dev.log(itemTotal.toString());
  //   notifyListeners();
  // }

  // void decrementPriceDetails(
  //   context, {
  //   String? itmprice,
  //   String? quntityMinues,
  // }) async {
  //   double? qtyMinues = double.parse(quntityMinues!);
  //   // if (qtyMinues <= 1) {
  //   //   // commonMessage(context, errorTxt: "Cannot enter - values").show();
  //   // } else {
  //   qty = qtyMinues;
  //   qty--;
  //   notifyListeners();
  //   double selectItmeprice = double.tryParse(itmprice.toString()) ?? 0;
  //   // totalBillAmount = selectItmeprice;
  //   double itemTotal = qty * selectItmeprice;
  //   totalBillAmount = itemTotal.toString();
  //   dev.log(itemTotal.toString());
  //   // }

  //   notifyListeners();
  // }

  double totalPrice = 0;
  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in getselectedProductDetailsModelData) {
      // Add the price of each item to the total price
      totalPrice += double.parse(item.price!);
    }
    return totalPrice;
  }

  double discountPrice = 0;
  double calculateDiscountPrice() {
    double discountPrice = 0;
    for (var item in getselectedProductDetailsModelData) {
      // Add the price of each item to the total price
      discountPrice += double.parse(item.discount!);
    }
    return discountPrice;
  }

  double subTotalPrice = 0;
  double subtotalPriceCalculator() {
    double subTotalPrice = 0;
    for (var item in getselectedProductDetailsModelData) {
      // Add the price of each item to the total price
      subTotalPrice += double.parse(item.totelPrice!);
    }
    return subTotalPrice;
  }
}
