import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:mobile_pos/model/itemdetails_model.dart';
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
}
