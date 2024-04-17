import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_pos/model/promotion_data_model.dart';
import 'package:mobile_pos/utils/message.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos/utils/url.dart';
import 'package:http/http.dart' as http;

class PromotionProvider extends ChangeNotifier {
  Future<void> getAllPromotionData(context) async {
    try {
      setloadPromotionData(true);
      var reqBody = {};
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kgetAllPromotionRecord),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      dev.log(response.body);

      GetAllPromotionModel temp =
          GetAllPromotionModel.fromJson(jsonDecode(response.body));
      dev.log(response.body);

      if (temp.success == 'success') {
        setallPromotionModelData(temp);
      } else {
        commonMessage(context, errorTxt: "No Promotion Founded").show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadPromotionData(false);
    }
  }

  bool loadPromotionData = false;
  bool get getloadPromotionData => loadPromotionData;
  setloadPromotionData(val) {
    loadPromotionData = val;
    notifyListeners();
  }

  GetAllPromotionModel? allPromotionModelData;
  GetAllPromotionModel? get getallPromotionModelData => allPromotionModelData;
  setallPromotionModelData(val) {
    allPromotionModelData = val;
    notifyListeners();
  }
}
