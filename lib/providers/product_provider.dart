import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_pos/model/bill_payment_reponse_model.dart';
import 'package:mobile_pos/model/itemdetails_model.dart';
import 'package:mobile_pos/model/selected_item_model.dart';
import 'package:mobile_pos/screens/main_home/dashboard/dashboard.dart';
import 'package:mobile_pos/utils/key_const.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:mobile_pos/utils/url.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

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
        commonMessage(context, errorTxt: "No Product Founded").show();
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
      // if (item.discount!.isNotEmpty) {
      discountPrice += double.parse(item.discount!);
      // }
      // Add the price of each item to the total price
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

  double itemCount = 0;
  double itemCountCalculator() {
    double itemCount = 0;
    itemCount +=
        double.parse(getselectedProductDetailsModelData.length.toString());

    return itemCount;
  }

  //save Bill
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('hh:mm:ss').format(DateTime.now());

  Future<void> completeBillRecord(context) async {
    var userEmail = await storage.read(key: kEmail);
    var usermobileNo = await storage.read(key: kmobileNo);
    var userName = await storage.read(key: kcustomername);
    setloadCompleBilldate(true);
    try {
      var reqBody = {
        "cus_email": userEmail,
        "cus_mobileno": usermobileNo,
        "cus_name": userName,
        "date_time": "$currentDate|$currentTime",
        "itemcount": itemCountCalculator().toString(),
        "item": [
          for (int i = 0; i < selectedProductDetailsModelData.length; i++)
            {
              "itemcode": selectedProductDetailsModelData[i].no,
              "name": selectedProductDetailsModelData[i].itemName,
              "qty": selectedProductDetailsModelData[i].qty,
              "amount": selectedProductDetailsModelData[i].price,
              "discount_price": selectedProductDetailsModelData[i].discount,
              "itemTotal": selectedProductDetailsModelData[i].totelPrice
            },
        ],
        "total_amount": calculateTotalPrice().toString(),
        "tdiscount_amount": calculateDiscountPrice().toString(),
        "subtotal": subtotalPriceCalculator().toString()
      };

      // dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kbillPayment),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      dev.log(response.body);

      BillPaymentResponseMessage temp =
          BillPaymentResponseMessage.fromJson(jsonDecode(response.body));
      dev.log(response.body);

      if (temp.success == 'Success') {
        setbillPaymentResponseMessageData(temp);
        commonMessage(context,
            errorTxt: temp.message.toString(),
            btnType: 3,
            buttons: [
              DialogButton(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dashbaord(),
                      ),
                      (route) => false);
                  clearBillPaymentScreenData(context);
                },
              )
            ]).show();
      } else {
        setbillPaymentResponseMessageData(temp);
        commonMessage(context, errorTxt: temp.message.toString()).show();
      }
    } catch (e) {
      setloadCompleBilldate(false);
      dev.log(e.toString());
    } finally {
      setloadCompleBilldate(false);
    }
  }

  bool loadCompleBilldate = false;
  bool get getloadCompleBilldate => loadCompleBilldate;
  setloadCompleBilldate(val) {
    loadCompleBilldate = val;
    notifyListeners();
  }

  BillPaymentResponseMessage? billPaymentResponseMessageData;
  BillPaymentResponseMessage? get getbillPaymentResponseMessageData =>
      billPaymentResponseMessageData;
  setbillPaymentResponseMessageData(val) {
    billPaymentResponseMessageData = val;
    notifyListeners();
  }

  Future<void> clearBillPaymentScreenData(context) async {
    for (int i = 0; i < selectedProductDetailsModelData.length;) {
      removeaddItemRecords(selectedProductDetailsModelData[i]);
    }
    setloadCompleBilldate(false);
    notifyListeners();
  }
}
